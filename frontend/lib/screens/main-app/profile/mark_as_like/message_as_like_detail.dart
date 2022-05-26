import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/back_and_delete_appbar.dart';
import 'package:flutter_application_1/component/popup_page/delete_popup.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/theme/index.dart';

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

  @override
  Widget build(BuildContext context) {
    List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAndDeleteAppBar(
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
      body: Column(
        children: [
          Container(
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05),
            width: double.infinity,
            height: size.height * 0.42,
            color: widget.color == 2 ? colors[0] : colors[widget.color + 1],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.translate.toString(),
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
