import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class ReportTypeChoice extends StatefulWidget {
  final text;
  final userid;
  final chatid;
  const ReportTypeChoice(
      {Key? key,
      required this.text,
      required this.userid,
      required this.chatid})
      : super(key: key);

  @override
  State<ReportTypeChoice> createState() => _ReportTypeChoice();
}

class _ReportTypeChoice extends State<ReportTypeChoice> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String urlImage = '';
  String reportFilled = '';

  TextEditingController descController = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference reportUser =
      FirebaseFirestore.instance.collection('ReportUser');
  CollectionReference chats =
      FirebaseFirestore.instance.collection('ChatRooms');

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

  sendReport() async {
    DocumentReference docRef = await reportUser.add({
      'reportHeader': widget.text,
      'reportDetail': reportFilled,
      'reportImage': urlImage,
      'reportTime': DateTime.now(),
      'reportBy': currentUser!.uid,
    });
    await users.doc(widget.userid).update({
      'report': FieldValue.arrayUnion([docRef.id]),
    });
    unMatch();
  }

  unMatch() async {
    await users.doc(widget.userid).update({
      'chats': FieldValue.arrayRemove([widget.chatid]),
      'likesby': FieldValue.arrayRemove([currentUser!.uid]),
      'liked': FieldValue.arrayRemove([currentUser!.uid]),
    });
    await users.doc(currentUser!.uid).update({
      'chats': FieldValue.arrayRemove([widget.chatid]),
      'likesby': FieldValue.arrayRemove([widget.userid]),
      'liked': FieldValue.arrayRemove([widget.userid]),
    });
    await chats.doc(widget.chatid).delete();
    Navigator.of(context).pushNamed(Routes.JassyHome, arguments: 3);
  }

  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      child: InkWell(
        onTap: () {
          // Navigator.pop(context);
          showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              context: context,
              builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          "MenuReport".tr,
                          style: TextStyle(fontSize: 16),
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 0.0),
                          child: Text(
                            "ReportDetail".tr,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        TextFormField(
                          controller: descController,
                          onChanged: (desc) {
                            desc = descController.text;
                            reportFilled = desc;
                          },
                          decoration: InputDecoration(
                            hintText: "ReportFill".tr,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 10.0),
                            child: Row(children: [
                              Text(
                                "ReportAttach".tr,
                                style: TextStyle(fontSize: 16),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(
                                  color: secoundary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ])),
                        OutlinedButton.icon(
                            onPressed: selectFile,
                            icon: const Icon(
                              Icons.file_upload,
                              color: primaryColor,
                            ),
                            label: Text(
                              "ReportAddFile".tr,
                              style: TextStyle(color: primaryColor),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(159, 36),
                              side: const BorderSide(color: primaryColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            )),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: pickedFile != null
                                  ? Container(
                                      child: Text(
                                        pickedFile!.name,
                                        style: TextStyle(color: grey),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Center(
                          child: RoundButton(
                            text: "MenuReport".tr,
                            minimumSize: const Size(339, 36),
                            press: () async {
                              await uploadFile();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return WarningPopUpWithButton(
                                      text: 'WarningReport'.tr,
                                      okPress: () {
                                        sendReport();
                                      },
                                    );
                                  });
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ));
        },
        child: Row(
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
