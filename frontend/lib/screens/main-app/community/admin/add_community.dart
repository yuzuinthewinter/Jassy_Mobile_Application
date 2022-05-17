import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/text/report_choice.dart';
import 'package:flutter_application_1/component/text/text_field_label.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/component/group_for_search_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddNewCommunity extends StatefulWidget {
  final user;
  const AddNewCommunity(this.user, {Key? key}) : super(key: key);

  @override
  State<AddNewCommunity> createState() => _NewCommunityState();
}

class CommuType {
  String namegroup;
  String coverPicture;
  List<String> member;
  List<String> posts;

  CommuType({
    this.namegroup = '',
    this.coverPicture = '',
    this.member = const [],
    this.posts = const [],
  });
}

class _NewCommunityState extends State<AddNewCommunity> {
  CommuType commu = CommuType();
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String urlImage = '';

  TextEditingController communitynameController = TextEditingController();
  CollectionReference community =
      FirebaseFirestore.instance.collection('Community');

  createCommunity() async {
    DocumentReference docRef = await community.add({
      'membersID': const [],
      'postsID': const [],
      'namegroup': commu.namegroup.toLowerCase(),
      'coverPic': urlImage,
    });
    await community.doc(docRef.id).update({
      'groupid': docRef.id,
    });
  }

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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    communitynameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: BackAndCloseAppBar(
          text: "การเพิ่มกลุ่ม",
        ),
        body: Column(
          key: _formKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CurvedWidget(
              child: HeaderStyle2(),
            ),
            const HeaderText(text: "สร้างข้อมูลสำหรับกลุ่มชุมชน"),
            const DescriptionText(text: "กรุณากรอกข้อมูลสำหรับชุมชนใหม่ของคุณ"),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const RequiredTextFieldLabel(textLabel: "ชื่อชุมชน"),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: communitynameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "ชื่อชุมชน",
                                hintStyle: const TextStyle(color: greyDark),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                fillColor: textLight,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        color: textLight, width: 0.0)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide:
                                      const BorderSide(color: textLight),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide:
                                      const BorderSide(color: textLight),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (String? namegroup) {
                                namegroup = communitynameController.text;
                                commu.namegroup = namegroup;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            const TextFieldLabel(
                                textLabel: "อัพโหลดรูปภาพสำหรับหน้าปกชุมชน"),
                            OutlinedButton.icon(
                                onPressed: selectFile,
                                icon: const Icon(
                                  Icons.file_upload,
                                  color: primaryColor,
                                ),
                                label: const Text(
                                  "เพิ่มรูปภาพหน้าปกชุมชน",
                                  style: TextStyle(color: primaryColor),
                                ),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(159, 36),
                                  side: const BorderSide(color: primaryColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                )),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: pickedFile != null
                                      ? Container(
                                          child: Image.file(
                                          File(pickedFile!.path!),
                                          height: size.height * 0.2,
                                        ))
                                      : Container(height: 3),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.14,
                            ),
                            Center(
                              child: RoundButton(
                                text: "สร้างชุมชน",
                                minimumSize: const Size(279, 36),
                                press: () async {
                                  await uploadFile();
                                  createCommunity();
                                  Navigator.pushNamed(
                                    context,
                                    Routes.AdminJassyHome,
                                  );
                                },
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
