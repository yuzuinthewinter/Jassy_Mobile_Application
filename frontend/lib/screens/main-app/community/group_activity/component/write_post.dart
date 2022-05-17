import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/appbar/write_post_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/group_activity_screen.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String urlImage = '';
  String postText = '';

  CollectionReference community =
      FirebaseFirestore.instance.collection('Community');
  CollectionReference posts = FirebaseFirestore.instance.collection('Posts');

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'community/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      urlImage = urlDownload;
      uploadTask = null;
    });
  }

  createPost() async {
    DocumentReference docRef = await posts.add({
      'postby': widget.user['uid'],
      'groupid': widget.group['groupid'],
      'text': postText,
      'picture': urlImage,
      'date': DateTime.now(),
      'reported': const [],
      'likes': const [],
      'comments': const [],
    });
    await posts.doc(docRef.id).update({
      'postid': docRef.id,
    });
    await community.doc(widget.group['groupid']).update({
      'postsID': FieldValue.arrayUnion([docRef.id]),
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    writingTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: WritePostAppBar(onPress: () async {
        if (pickedFile != null) {
          await uploadFile();
        }
        createPost();
        Navigator.pop(context);
      }),
      body: Container(
        color: textLight,
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurvedWidget(
                    child: JassyGradientColor(
                  gradientHeight: size.height * 0.23,
                )),
                Expanded(
                  child: KeyboardActions(
                    config: _buildConfig(context),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: size.width * 0.05),
                              child: CircleAvatar(
                                backgroundImage: !widget.user['profilePic'].isEmpty
                                    ? NetworkImage(widget.user['profilePic'][0])
                                    : const AssetImage("assets/images/user3.png")
                                        as ImageProvider,
                                radius: size.width * 0.05,
                              ),
                            ),
                            Text(
                              '${StringUtils.capitalize(widget.user['name']['firstname'])} ${StringUtils.capitalize(widget.user['name']['lastname'])}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
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
                        pickedFile != null 
                        ? Image.file(File(pickedFile!.path!), fit: BoxFit.cover, height: MediaQuery.of(context).size.height * 0.6, width: double.infinity,)
                        : Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
      ),
    );
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.add_photo_alternate,
                        size: 28,
                        color: primaryColor,
                      ),
                      Text(
                        "GroupPostAddPic".tr,
                        style: const TextStyle(
                            color: textDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
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
}
