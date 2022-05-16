import 'dart:io';
import 'package:basic_utils/basic_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/write_post_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

// Todo: crop Image file + แจ้งเตือน + ออกกลุ่ม
class WritePost extends StatefulWidget {
  final user;
  final group;
  const WritePost(this.user, this.group, {Key? key}) : super(key: key);

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  TextEditingController writingTextController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  FocusNode writingTextFocus = FocusNode();
  final bool _isLoading = false;
  late File _postImageFile;

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String urlImage = '';

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: greyLightest,
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: _nodeText1,
        ),
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: writingTextFocus,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () {
                  selectFile();
                },
                child: Container(
                  color: greyLightest,
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_photo_alternate,
                        size: 28,
                        color: primaryColor,
                      ),
                      Text(
                        "GroupPostAddPic".tr,
                        style: TextStyle(
                            color: textDark,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: WritePostAppBar(onPress: () {}),
      body: Container(
        color: textLight,
        child: KeyboardActions(
          config: _buildConfig(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurvedWidget(
                  child: JassyGradientColor(
                gradientHeight: size.height * 0.23,
              )),
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: CircleAvatar(
                      backgroundImage:
                          const AssetImage("assets/images/user3.jpg"),
                      radius: size.width * 0.05,
                    ),
                  ),
                  Text(
                    '${StringUtils.capitalize(widget.user['name']['firstname'])} ${StringUtils.capitalize(widget.user['name']['lastname'])}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                child: Expanded(
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "GroupPostHintText".tr,
                      hintMaxLines: 4,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    focusNode: writingTextFocus,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _getImageAndCrop() async {
  //   File imageFileFromGallery = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (imageFileFromGallery != null) {
  //     File cropImageFile = await Utils.cropImageFile(imageFileFromGallery);//await cropImageFile(imageFileFromGallery);
  //     if (cropImageFile != null) {
  //       setState(() {
  //         _postImageFile = cropImageFile;
  //       });
  //     }
  //   }
  // }
}
