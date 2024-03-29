import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:camera/camera.dart';
// import 'package:faceid_mobile/screens/preview_screen.dart';
// import 'package:faceid_mobile/utils/utils.dart' as Utils;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_application_1/screens/pre-app/facereg/preview_picture.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as ImageLib;
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() {
    return _CameraScreenState();
  }
}

enum Status { RIGHT, LEFT, SMILE, NEUTRAL, EYES_CLOSED, GLASSES }

class _CameraScreenState extends State {
  // This class is responsible for establishing a connection to the device’s camera.

  CameraDescription camera = const CameraDescription(
      lensDirection: CameraLensDirection.front, name: '', sensorOrientation: 0);
  CameraController controller = CameraController(
      const CameraDescription(
          lensDirection: CameraLensDirection.front,
          name: '',
          sensorOrientation: 0),
      ResolutionPreset.medium);
  List cameras = [];
  int selectedCameraIdx = 1;
  Map<Status, String> imagePaths = <Status, String>{};
  bool isProcessing = false;
  String error = '';
  Status currentStatus = Status.NEUTRAL;

  //
  Set<Status> listOfStatus = {Status.NEUTRAL};

  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // listOfStatus.addAll(Status.values);
    availableCameras().then((availableCameras) {
      availableCameras.forEach((element) {
        print(element.name);
      });
      cameras = availableCameras;
      camera = cameras.first;

      controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      if (cameras.isNotEmpty) {
        setState(() {
          selectedCameraIdx = selectedCameraIdx < cameras.length - 1
              ? selectedCameraIdx + 1
              : 0;
        });

        // _initializeControllerFuture = controller.initialize();
        _initCameraController(cameras[selectedCameraIdx]);
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high,
        enableAudio: false);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      // _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _cameraPreviewWidget(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Display Camera preview.
  Widget _cameraPreviewWidget(context) {
    if (!controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    // Todo : make the bottom buttons transparent and stacked on the camera preview
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      //
      child: Stack(
        children: <Widget>[
          CameraPreview(controller),
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.2),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black54
                ],
              ),
            ),
            child:  Text(
              'Smile'.tr,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    color: Colors.black),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          _onAutoCapture(context);
                        },
                        iconSize: 50,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.circle, color: Colors.white),
                      )),
                    ]),
              )),
        ],
      ),
    );
  }

  XFile? imageFile;

  void _onAutoCapture(BuildContext context) async {
    _resetState(processing: true);
    try {
      final path = await join(
        // store the picture in the temp directory.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      await controller.takePicture().then((XFile? file) {
        if (mounted) {
          setState(() {
            imageFile = file;
          });
          if (file != null) {
            print('Picture saved to ${file.path}');
          }
        }
      });
      ;
      print('after take picture');
      _getImageAndDetectFaces(path, context);
    } catch (e) {
      print('error on auto');
      print(e);
    }
  }

  void _getImageAndDetectFaces(String path, BuildContext context) async {
    try {
      FirebaseVisionImage image =
          FirebaseVisionImage.fromFile(File(imageFile!.path));
      FaceDetector faceDetector = FirebaseVision.instance.faceDetector(
          const FaceDetectorOptions(
              mode: FaceDetectorMode.fast,
              enableClassification: true,
              enableLandmarks: true));
      List<Face> faces = await faceDetector.processImage(image);
      print(faces.length.toString());
      if (mounted) {
        if (faces.isNotEmpty) {
          print('face detected');
          if (faces.length > 1) {
          //Todo: add translation
            Flushbar(
              message: "More than one person detect",
              backgroundColor: textMadatory,
              duration: const Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
            ).show(context);
            setState(() {
              isProcessing = false;
              error = "WarningTakePictureMoreThanOnePerson".tr;
            });
          } else {
            _processFaceSmile(context, path, faces[0]);
          }
        } else {
          //Todo: add translation
          Flushbar(
            message: "No person in pic",
            backgroundColor: textMadatory,
            duration: const Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
          ).show(context);
          print('no one');
          setState(() {
            isProcessing = false;
            error = "WarningTakePictureNoOne".tr;
          });
        }
        if (error != '') {
          print('error');
        } else {
          //todo: popup success
          print('success');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _processFaceSmile(BuildContext context, String path, Face face) {
    {
      print('is process face smile');
      setState(() {
        isProcessing = false;
      });
      print('[smilingProbability] ' + face.smilingProbability.toString());
      if (face.smilingProbability < 0.80) {
        Flushbar(
          message: "You're not smiling",
          backgroundColor: textMadatory,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
        setState(() {
          error = "You're not smiling";
        });
      } else {
        if (error == '') {
          imagePaths[currentStatus] = path;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PreviewPicture(imageFile: File(imageFile!.path))),
          );
        }
      }
    }
  }

  void _resetState({processing = false}) {
    setState(() {
      isProcessing = processing;
      error = '';
    });
  }

  void _cropAndSaveImage(String path, Face face) {
    final ImageLib.Image? capturedImage =
        ImageLib.decodeImage(File(imageFile!.path).readAsBytesSync());
    final ImageLib.Image copy = ImageLib.copyCrop(
        capturedImage!,
        face.boundingBox.topLeft.dy.toInt(),
        face.boundingBox.topLeft.dx.toInt(),
        face.boundingBox.width.toInt(),
        face.boundingBox.height.toInt());
    final ImageLib.Image orientedImage = ImageLib.bakeOrientation(copy);
    File(imageFile!.path).writeAsBytesSync(ImageLib.encodePng(orientedImage));
  }
}
