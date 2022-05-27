import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
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
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';

class PictureUpload extends StatefulWidget {
  const PictureUpload({Key? key}) : super(key: key);

  @override
  State<PictureUpload> createState() => _PictureUploadState();
}

class _PictureUploadState extends State<PictureUpload> {
  XFile? imagePath;
  String imageName = '';

  // ui.Image? image;
  // List<Rect> rect = <Rect>[];

  // Future<ui.Image> loadImage(File image) async {
  //   var img = await image.readAsBytes();
  //   return await decodeImageFromList(img);
  // }

  late File pickedImage;
  var imageFile;

  bool isImageLoaded = false;
  bool isFaceDetected = false;

  List<Rect> rect = <Rect>[];

  Future pickImage() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      imageFile = await image.readAsBytes();
      imageFile = await decodeImageFromList(imageFile);

      setState(() {
        pickedImage = File(image.path);

        imagePath = image;
        imageName = image.name.toString();
        imageFile = imageFile;

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

  var result = '';

  Future detectFace() async {
    result = '';
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(pickedImage);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(myImage);

    if (rect.isNotEmpty) {
      rect = <Rect>[];
    }

    for (Face face in faces) {
      rect.add(face.boundingBox);
    }

    setState(() {
      isFaceDetected = true;
    });
  }

  var users = FirebaseFirestore.instance.collection('Users');

  _uploadImage() async {
    var users = FirebaseFirestore.instance.collection('Users');
    var currentUser = FirebaseAuth.instance.currentUser;

    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference =
        FirebaseStorage.instance.ref().child('profilePics/${uploadFileName}');
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));

    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          "\t" +
          event.totalBytes.toString());
    });

    _showMessage() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went wrong"),
        duration: Duration(seconds: 2),
      ));
    }

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

      if (uploadPath.isNotEmpty) {
        users.doc(currentUser!.uid).update({
          'profilePic': [uploadPath]
        }).then((value) => null);
      } else {
        _showMessage();
      }
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
          HeaderText(text: "ProfilePictureUpload".tr),
          DescriptionText(text: "ProfilePictureDesc".tr),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: Text(
              "ProfilePictureWarning".tr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: secoundary),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.015,
                ),
                isImageLoaded && !isFaceDetected
                    ? Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(
                            File(imagePath!.path),
                            fit: BoxFit.cover,
                            height: size.height * 0.3,
                            width: size.width * 0.65,
                          ),
                        ),
                      )
                    : isImageLoaded && isFaceDetected
                        ? Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: SizedBox(
                                height: size.height * 0.3,
                                width: size.width * 0.65,
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
                          )
                        : Container(),
              ],
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButtonComponent(
                  text: "ProfilePictureUploadButton".tr,
                  minimumSize: Size(size.width * 0.55, size.height * 0.05),
                  press: () {
                    pickImage();
                  }),
              Center(
                child: DisableToggleButton(
                  color: imagePath != null ? primaryColor : grey,
                  text: "NextButton".tr,
                  minimumSize: Size(size.width * 0.35, size.height * 0.05),
                  press: () async {
                    if (imagePath != null) {
                      if (rect.length > 1) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return WarningPopUpWithButton(
                                text:
                                    '${'WarningPictureMoreThanOnePerson'.tr} : ${rect.length}',
                                okPress: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                      } else if (rect.length == 1) {
                        await _uploadImage();
                        //todo: next
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return WarningPopUpWithButton(
                                text: 'WarningReport'.tr,
                                okPress: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                      }
                    }
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
