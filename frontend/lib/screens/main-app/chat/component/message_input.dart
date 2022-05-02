import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
  List<String> status = ['sending', 'sent', 'read'];
  var currentUser = FirebaseAuth.instance.currentUser;

  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  sendMessage(message) async {
    CollectionReference chats =
        FirebaseFirestore.instance.collection('ChatRooms');
    CollectionReference messages =
        FirebaseFirestore.instance.collection('Messages');
    DocumentReference docRef = await messages.add({
      'message': message,
      'sentBy': currentUser!.uid,
      'date': DateTime.now(),
      'time': DateTime.now(),
      'type': '',
      'status': '',
    });
    await messages.doc(docRef.id).update({
      'messageID': docRef.id,
    });
    await chats.doc(widget.chatid).update({
      'messages': FieldValue.arrayUnion([docRef.id]),
      'lastMessageSent': message,
      'lastTimestamp': DateTime.now(),
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Row(
          children: [
            InkWell(
                // TODO: add add icon detail (ammie)
                onTap: () {},
                child: SvgPicture.asset("assets/icons/add_circle.svg")),
            SizedBox(
              width: widget.size.height * 0.01,
            ),
            Expanded(
                child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "พิมพ์ข้อความ",
                suffixIcon: InkWell(
                    // TODO : add emoji picker (ammie)
                    onTap: () {
                      print("emoji");
                    },
                    child: const Icon(
                      Icons.sentiment_satisfied_alt,
                      color: primaryColor,
                    )),
                filled: true,
                fillColor: textLight,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide:
                        const BorderSide(color: primaryLighter, width: 0.0)),
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
                onTap: () => sendMessage(messageController.text),
                child: SvgPicture.asset("assets/icons/send.svg"))
          ],
        ));
  }
}
