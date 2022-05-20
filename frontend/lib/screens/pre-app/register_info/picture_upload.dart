import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
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

  File? image;
  Future pickImage () async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Fail to pick image $e');
    }
  }

  PlatformFile? pickedFile;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
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
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: Text(
              "ProfilePictureWarning".tr,
              textAlign: TextAlign.left,
              style: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w500,
              color: secoundary
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.015,),
                  image != null 
                  ? Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.file(
                        image!, 
                        fit: BoxFit.cover, 
                        height: size.height * 0.3, 
                        width: size.width * 0.65,
                      ),
                    ),
                  )
                  : Container(),
                ],
              ),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButtonComponent(
                text: "ProfilePictureUploadButton".tr, 
                minimumSize: Size(size.width * 0.55, size.height * 0.05), 
                press: () {
                  pickImage();
                }
              ),
              Center(
                child: DisableToggleButton(
                  color: image != null ? primaryColor : grey,
                  text: "NextButton".tr,
                  minimumSize: Size(size.width * 0.35, size.height * 0.05),
                  press: () {
                    // Todo: face reg
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