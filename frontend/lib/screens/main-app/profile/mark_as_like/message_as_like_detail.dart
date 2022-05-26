import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/back_and_delete_appbar.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/popup_page/delete_popup.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';

class MessageAsLikeDetail extends StatefulWidget {
  final int color;
  final message;
  final language;
  final translate;
  const MessageAsLikeDetail(
      {Key? key,
      required this.color,
      required this.message,
      required this.language,
      required this.translate})
      : super(key: key);

  @override
  State<MessageAsLikeDetail> createState() => _MessageAsLikeDetailState();
}

class _MessageAsLikeDetailState extends State<MessageAsLikeDetail> {
  var currentUser = FirebaseAuth.instance.currentUser;

  removeMemo() async {
    CollectionReference memo =
        FirebaseFirestore.instance.collection('MemoMessages');
    await memo.doc(currentUser!.uid).update({
      '${widget.language}':
          FieldValue.arrayRemove([widget.message['messageID']]),
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAndDeleteAppBar(
          text: widget.translate.sourceLanguage.toString().toUpperCase(),
          color: colors[widget.color],
          delete: () {
            // Todo: delete item
            showDialog(
                context: context,
                builder: (context) {
                  return DeleteWarningPopUp(onPress: () {
                    removeMemo();
                  });
                });
          }),
      body: Container(
        color: isShow ? colors[widget.color] : widget.color == 2 ? colors[0] : colors[widget.color + 1],
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                width: double.infinity,
                height: size.height * 0.3,
                color: colors[widget.color],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.message['message'],
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            !isShow ? Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: size.height * 0.05),
                width: double.infinity,
                height: size.height * 0.42,
                color: widget.color == 2 ? colors[0] : colors[widget.color + 1],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.translate.targetLanguage.toString().toUpperCase(),
                          style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Text(
                      widget.translate.toString(),
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ) : const SizedBox.shrink(),
            RoundButton(
              text: isShow ? "Translate".tr : "Cancel".tr, 
              minimumSize: Size(size.width * 0.8, size.height * 0.05), 
              press: () {
                setState(() {
                  isShow = !isShow;
                });
              }
            ),
            SizedBox(height: size.height * 0.02,)
          ],
        ),
      ),
    );
  }
}
