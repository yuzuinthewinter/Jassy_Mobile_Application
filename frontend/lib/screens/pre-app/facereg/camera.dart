import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:image/image.dart' as ImageLib;
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class OpenCamera extends StatefulWidget {
  const OpenCamera({Key? key}) : super(key: key);

  // final List<CameraDescription> cameras;, required this.cameras

  @override
  State<OpenCamera> createState() => _OpenCameraState();
}

enum Status { RIGHT, LEFT, SMILE, NEUTRAL, EYES_CLOSED, GLASSES }

class _OpenCameraState extends State<OpenCamera> {
  CameraDescription camera = CameraDescription(
      lensDirection: CameraLensDirection.front, name: '', sensorOrientation: 0);
  CameraController _cameraController = CameraController(
      CameraDescription(
          lensDirection: CameraLensDirection.front,
          name: '',
          sensorOrientation: 0),
      ResolutionPreset.medium);
  List cameras = [];
  int selectedCameraIdx = 1;
  // bool _isRearCameraSelected = true;

  bool isProcessing = false;
  String error = '';

  Map<Status, String> imagePaths = <Status, String>{};
  Status currentStatus = Status.NEUTRAL;
  Set<Status> listOfStatus = {Status.NEUTRAL};

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initCamera(cameras[selectedCameraIdx]);
    availableCameras().then((availableCameras) {
      for (var element in availableCameras) {
        print(element.name);
      }
      cameras = availableCameras;
      camera = cameras.first;

      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      if (cameras.isNotEmpty) {
        setState(() {
          selectedCameraIdx = 1;
        });
        print(selectedCameraIdx.toString());
        initCamera(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  void _resetState({processing = false}) {
    setState(() {
      isProcessing = processing;
      error = '';
    });
  }

  void _getImageAndDetectFaces(String path, BuildContext context) async {
    final image = FirebaseVisionImage.fromFilePath(path);
    final faceDetector = FirebaseVision.instance
        .faceDetector(const FaceDetectorOptions(enableClassification: true));
    List<Face> faces = await faceDetector.processImage(image);
    if (mounted) {
      if (faces.isNotEmpty) {
        if (faces.length > 1) {
          setState(() {
            isProcessing = false;
            error = "WarningTakePictureMoreThanOnePerson".tr;
          });
        } else {
          _processFaceSmile(context, path, faces[0]);
        }
      } else {
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
  }

  void _processFaceSmile(BuildContext context, String path, Face face) {
    {
      setState(() {
        isProcessing = false;
      });

      if (face.smilingProbability < 0.80) {
        setState(() {
          error = "You're not smiling";
        });
      }

      if (error == '') {
        imagePaths[currentStatus] = path;
        _cropAndSaveImage(path, face);
        print('is cropped');
        // if (!isProcessing) {
        //   _onAutoCapture(context);
        // }
      }
    }
  }

  void _cropAndSaveImage(String path, Face face) {
    final ImageLib.Image? capturedImage =
        ImageLib.decodeImage(File(path).readAsBytesSync());
    final ImageLib.Image copy = ImageLib.copyCrop(
        capturedImage!,
        face.boundingBox.topLeft.dy.toInt(),
        face.boundingBox.topLeft.dx.toInt(),
        face.boundingBox.width.toInt(),
        face.boundingBox.height.toInt());
    final ImageLib.Image orientedImage = ImageLib.bakeOrientation(copy);
    File(path).writeAsBytesSync(ImageLib.encodePng(orientedImage));
    //upload image
    // loading
  }

  Future takePicture(context) async {
    _resetState(processing: true);
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      final path = join(
        // store the picture in the temp directory.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      // await _cameraController.setFlashMode(FlashMode.off);
      // XFile picture = await _cameraController.takePicture();
      _getImageAndDetectFaces(path, context);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => PreviewPage(
      //               picture: picture,
      //             )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        (_cameraController.value.isInitialized)
            ? CameraPreview(_cameraController)
            : Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator())),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  color: Colors.black),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // Expanded(
                //     child: IconButton(
                //   padding: EdgeInsets.zero,
                //   iconSize: 30,
                //   icon: Icon(
                //       // _isRearCameraSelected
                //       //     ? CupertinoIcons.switch_camera
                //       //     :
                //       CupertinoIcons.switch_camera_solid,
                //       color: Colors.white),
                //   onPressed: () {
                //     // setState(
                //     //     () => _isRearCameraSelected = !_isRearCameraSelected);
                //     initCamera(cameras[selectedCameraIdx]);
                //   },
                // )),
                Expanded(
                    child: IconButton(
                  onPressed: () {
                    takePicture(context);
                  },
                  iconSize: 50,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.circle, color: Colors.white),
                )),
                const Spacer(),
              ]),
            )),
      ]),
    ));
  }
}
