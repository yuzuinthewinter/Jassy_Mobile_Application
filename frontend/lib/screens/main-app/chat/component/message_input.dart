import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controllers/reply.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MessageInput extends StatefulWidget {
  final Size size;
  final chatid;

  const MessageInput({
    Key? key,
    required this.size,
    required this.chatid,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<MessageInput> {
  //list flow message
  List<String> status = ['unread', 'read'];
  var currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference chats =
      FirebaseFirestore.instance.collection('ChatRooms');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('Messages');

  TextEditingController messageController = TextEditingController();
  ReplyController replyController = Get.put(ReplyController());
  bool _isReply = false;
  bool isCurrentChat = false;
  String _chatid = '';
  String _message = '';
  String typemessage = 'text';
  int count = 0;

  @override
  void dispose() {
    replyController.updateReply('', false, '', typemessage);
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _isReply = replyController.isReply.value;
    _message = replyController.message.value.toString();
    _chatid = replyController.chatid.value.toString();
    if (_chatid == widget.chatid) {
      isCurrentChat = true;
    }
    super.initState();
    getCurrentCount();
  }

  getCurrentCount() async {
    var snapshot = await chats.where('chatid', isEqualTo: widget.chatid).get();
    if (snapshot.docs.isNotEmpty) {
      count = snapshot.docs[0]['unseenCount'];
    }
  }

  sendMessage(message, type) async {
    DocumentReference docRef = await messages.add({
      'message': message,
      'sentBy': currentUser!.uid,
      'date': DateTime.now(),
      'time': DateTime.now(),
      'type': type,
      'status': 'unread',
      'isReplyMessage': _isReply,
      'replyFromMessage': _message,
      'url': urlFile,
    });
    messageController.clear();
    await messages.doc(docRef.id).update({
      'messageID': docRef.id,
    });
    await chats.doc(widget.chatid).update({
      'messages': FieldValue.arrayUnion([docRef.id]),
      'sentBy': currentUser!.uid,
      'lastMessageSent': message,
      'lastTimestamp': DateTime.now(),
      'unseenCount': FieldValue.increment(1),
      'type': type,
    });
    replyController.updateReply('', false, '', type);
  }

  File? pickedImage;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        pickedImage = imageTemporary;
        typemessage = 'image';
      });
      await uploadImage();
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
      typemessage = 'file';
    });
    await uploadFile();
  }

  UploadTask? uploadTask;
  String urlFile = '';

  Future uploadImage() async {
    final imageFile = File(pickedImage!.path);
    final path = 'conversations/${pickedImage!.path}';

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(imageFile);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      urlFile = urlDownload;
      uploadTask = null;
    });
  }

  Future uploadFile() async {
    final path = 'conversations/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      urlFile = urlDownload;
      uploadTask = null;
    });
  }

  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: GetX<ReplyController>(
      init: ReplyController(),
      builder: (controller) {
        _isReply = controller.isReply.value;
        _message = controller.message.value;
        return Column(
          children: [
            _isReply
                ? !isCurrentChat
                    ? Container(
                        alignment: Alignment.centerLeft,
                        height: size.height * 0.1,
                        padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            left: size.height * 0.03,
                            right: size.height * 0.03),
                        child: Row(children: [
                          const Text(
                            'Reply : ',
                            style: TextStyle(color: greyDark, fontSize: 14),
                          ),
                          controller.type.value == 'text'
                              ? Text(
                                  controller.message.value,
                                  style:
                                      TextStyle(color: greyDark, fontSize: 14),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : controller.type.value == 'image'
                                  ? Image.network(
                                      controller.message.value,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      fit: BoxFit.contain,
                                    )
                                  : const Text(
                                      'File',
                                      style: TextStyle(
                                          color: greyDark, fontSize: 14),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                          const Spacer(),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          controller.isReply.value = false;
                                          _isReply = controller.isReply.value;
                                        });
                                        replyController.updateReply(
                                            '', _isReply, _chatid, typemessage);
                                      },
                                      child: SvgPicture.asset(
                                        "assets/icons/close_circle.svg",
                                        width: size.height * 0.05,
                                      )))),
                        ]))
                    : const SizedBox.shrink()
                : const SizedBox.shrink(),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: Row(
                  children: [
                    InkWell(
                        // TODO: add add icon detail (ammie)
                        onTap: () {
                          print(isMore);
                          setState(() {
                            isMore = !isMore;
                          });
                          FocusScope.of(context).unfocus();
                          print(isMore);
                        },
                        child: SvgPicture.asset("assets/icons/add_circle.svg")),
                    SizedBox(
                      width: widget.size.height * 0.01,
                    ),
                    Expanded(
                        child: TextField(
                      onTap: () {
                        setState(() {
                          isMore = false;
                        });
                      },
                      maxLines: null,
                      controller: messageController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "ChatHintText".tr,
                        filled: true,
                        fillColor: textLight,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                                color: primaryLighter, width: 0.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: const BorderSide(color: primaryLighter),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: const BorderSide(color: primaryLighter),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: widget.size.height * 0.02,
                    ),
                    InkWell(
                        onTap: () =>
                            sendMessage(messageController.text, typemessage),
                        child: SvgPicture.asset("assets/icons/send.svg")),
                  ],
                )),
            isMore
                ? Container(
                    height: size.height * 0.25,
                    padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.height * 0.03,
                        right: size.height * 0.03),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            selectFile();
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.description,
                                size: size.height * 0.05,
                                color: primaryColor,
                              ),
                              const Text("ไฟล์")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        InkWell(
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: size.height * 0.05,
                                color: primaryColor,
                              ),
                              const Text("ถ่ายภาพ")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        InkWell(
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: size.height * 0.05,
                                color: primaryColor,
                              ),
                              const Text("ส่งภาพ")
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        );
      },
    ));
  }
}
