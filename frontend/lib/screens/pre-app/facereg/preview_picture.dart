import 'dart:io';
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
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/pre-app/facereg/camera.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

  List<Rect> rect = <Rect>[];
  var result = '';

  var users = FirebaseFirestore.instance.collection('Users');
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchImage();
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
        // profileImage = Image.memory(bytes);
        // Image.file(File(XFile.path))
      }
      // var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (getFile == null) return;

      imageFile = await getFile.readAsBytes();
      imageFile = await decodeImageFromList(imageFile);

      imageProfileFile = await widget.imageFile.readAsBytes();
      imageProfileFile = await decodeImageFromList(imageProfileFile);

      setState(() {
        getImageFile = getFile;
        // profileImage = image;
        // imageName = image.name.toString();
        imageFile = imageFile;
        imageProfileFile = imageProfileFile;

        isImageLoaded = true;
        isFaceDetected = false;
      });

      if (isImageLoaded && !isFaceDetected) {
        detectFace(getImageFile);
        // detectFace(getImageFile);
      }
    } on PlatformException catch (e) {
      print('Fail to pick image $e');
    }
  }

  Future detectFace(visionImageFile) async {
    result = '';
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(visionImageFile);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector(
        const FaceDetectorOptions(
            mode: FaceDetectorMode.fast, enableLandmarks: true));
    List<Face> faces = await faceDetector.processImage(myImage);

    if (rect.isNotEmpty) {
      rect = <Rect>[];
    }
    for (Face face in faces) {
      rect.add(face.boundingBox);

      final img.Image? capturedImage =
          img.decodeImage(getImageFile.readAsBytesSync());
      final img.Image copy = img.copyCrop(
          capturedImage!,
          face.boundingBox.topLeft.dy.toInt(),
          face.boundingBox.topLeft.dx.toInt(),
          face.boundingBox.width.toInt(),
          face.boundingBox.height.toInt());
      final img.Image orientedImage = img.bakeOrientation(copy);
    }

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
                                              rect: rect, imageFile: imageFile),
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
                                        width: imageFile.width.toDouble(),
                                        height: imageFile.height.toDouble(),
                                        child: CustomPaint(
                                          painter: FacePainter(
                                              rect: rect,
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
