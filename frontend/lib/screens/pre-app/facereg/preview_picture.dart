import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_application_1/screens/pre-app/facereg/CameraScreen.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class PreviewPicture extends StatefulWidget {
  final File imageFile;
  const PreviewPicture({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<PreviewPicture> createState() => _PreviewPicture();
}

class _PreviewPicture extends State<PreviewPicture> {
  XFile? profileImage;
  XFile? faceregImage;
  XFile? imageCropPath;
  String imageName = '';

  late File getImageFile;
  var imageFile;
  var imageProfileFile;

  bool isImageLoaded = false;
  bool isFaceDetected = false;

  List<Rect> rect1 = <Rect>[];
  List<Rect> rect2 = <Rect>[];
  var result = '';
  var interpreter;

  var users = FirebaseFirestore.instance.collection('Users');
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchImage();
    loadModel();
  }

  void loadModel() async {
    interpreter = await tfl.Interpreter.fromAsset('model/mobilefacenet.tflite');
    print('Interpreter loaded successfully');
  }

  double euclideanDistance(List e1, List e2) {
    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  List e1 = [];
  List e2 = [];

  String _recog(img.Image img2, img.Image img1) {
    List input = imageToByteListFloat32(img1, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    List output = List.filled(1 * 192, null, growable: false).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    e1 = List.from(output);

    List input2 = imageToByteListFloat32(img2, 112, 128, 128);
    input2 = input2.reshape([1, 112, 112, 3]);
    List output2 = List.filled(1 * 192, null, growable: false).reshape([1, 192]);
    interpreter.run(input2, output2);
    output2 = output2.reshape([192]);
    e2 = List.from(output2);

    return compare(e2, e1).toUpperCase();
  }

  double threshold = 1.0;

  String compare(List withEmb, List currEmb) {
    double minDist = 999;
    double currDist = 0.0;
    String predRes = "NOT RECOGNIZED";
    currDist = euclideanDistance(withEmb, currEmb);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
      }
    print(minDist.toString() + " " + predRes);
    return predRes;
  }

  Float32List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }


  Future fetchImage() async {
    try {
      var snapshot =
          await users.where('uid', isEqualTo: currentUser!.uid).get();
      var getFile;
      if (snapshot.docs.isNotEmpty) {
        final profilePic = snapshot.docs[0]['profilePic'][0];
        final ByteData imageData =
            await NetworkAssetBundle(Uri.parse(profilePic)).load("");
        final Uint8List bytes = imageData.buffer.asUint8List();
        final tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}/profileImage.png').create();
        file.writeAsBytesSync(bytes);
        getFile = file;
      }

      if (getFile == null) return;

      imageFile = await getFile.readAsBytes();
      imageFile = await decodeImageFromList(imageFile);

      imageProfileFile = await widget.imageFile.readAsBytes();
      imageProfileFile = await decodeImageFromList(imageProfileFile);

      setState(() {
        getImageFile = getFile;

        imageFile = imageFile;
        imageProfileFile = imageProfileFile;

        isImageLoaded = true;
        isFaceDetected = false;
      });

      if (isImageLoaded && !isFaceDetected) {
        detectFace();
      }
    } on PlatformException catch (e) {
      print('Fail to pick image $e');
    }
  }

  late img.Image croppedImage1;
  late img.Image croppedImage2;

  Future detectFace() async {
    result = '';
    String res;
    FirebaseVisionImage myImage1 = FirebaseVisionImage.fromFile(getImageFile);
    FirebaseVisionImage myImage2 =
        FirebaseVisionImage.fromFile(widget.imageFile);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector(
        const FaceDetectorOptions(
            mode: FaceDetectorMode.fast, enableLandmarks: true));
    List<Face> faces1 = await faceDetector.processImage(myImage1);
    List<Face> faces2 = await faceDetector.processImage(myImage1);

    if (rect1.isNotEmpty) {
      rect1 = <Rect>[];
    }
    for (Face face in faces1) {
      rect1.add(face.boundingBox);

      final img.Image? capturedImage =
          img.decodeImage(getImageFile.readAsBytesSync());
      img.Image croppedImage = img.copyCrop(
          capturedImage!,
          face.boundingBox.topLeft.dy.toInt(),
          face.boundingBox.topLeft.dx.toInt(),
          face.boundingBox.width.toInt(),
          face.boundingBox.height.toInt());

      croppedImage1 = img.copyResizeCropSquare(croppedImage, 112);
    }
    if (rect2.isNotEmpty) {
      rect2 = <Rect>[];
    }
    for (Face face in faces2) {
      rect2.add(face.boundingBox);

      final img.Image? capturedImage =
          img.decodeImage(getImageFile.readAsBytesSync());
      img.Image croppedImage = img.copyCrop(
          capturedImage!,
          face.boundingBox.topLeft.dy.toInt(),
          face.boundingBox.topLeft.dx.toInt(),
          face.boundingBox.width.toInt(),
          face.boundingBox.height.toInt());

      croppedImage2 = img.copyResizeCropSquare(croppedImage, 112);
    }

      res = _recog(croppedImage2, croppedImage1);
    setState(() {
      isFaceDetected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
        text: "LandingRegister".tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurvedWidget(child: HeaderStyle2()),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.015,
                ),
                isImageLoaded && !isFaceDetected
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.file(
                                getImageFile,
                                fit: BoxFit.cover,
                                height: size.height * 0.35,
                                width: size.width * 0.35,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.file(
                                widget.imageFile,
                                fit: BoxFit.cover,
                                height: size.height * 0.35,
                                width: size.width * 0.35,
                              ),
                            ),
                          ),
                        ],
                      )
                    : isImageLoaded && isFaceDetected
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: SizedBox(
                                    height: size.height * 0.35,
                                    width: size.width * 0.35,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: SizedBox(
                                        width: imageFile.width.toDouble(),
                                        height: imageFile.height.toDouble(),
                                        child: CustomPaint(
                                          painter: FacePainter(
                                              rect: rect1,
                                              imageFile: imageFile),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: SizedBox(
                                    height: size.height * 0.35,
                                    width: size.width * 0.35,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: SizedBox(
                                        width:
                                            imageProfileFile.width.toDouble(),
                                        height:
                                            imageProfileFile.height.toDouble(),
                                        child: CustomPaint(
                                          painter: FacePainter(
                                              rect: rect2,
                                              imageFile: imageProfileFile),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
              ],
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: DisableToggleButton(
                  color: isImageLoaded && isFaceDetected ? primaryColor : grey,
                  text: "NextButton".tr,
                  minimumSize: Size(size.width * 0.9, size.height * 0.05),
                  press: () async {
                    if (profileImage != null) {}
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  List<Rect> rect;
  var imageFile;

  FacePainter({required this.rect, required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    for (Rect rectange in rect) {
      canvas.drawRect(
        rectange,
        Paint()
          ..color = textLight
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
