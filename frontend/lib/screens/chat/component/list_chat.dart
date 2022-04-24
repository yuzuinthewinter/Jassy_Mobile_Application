import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/chat/component/chat_card.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
class ListChat extends StatefulWidget {
  const ListChat({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<ListChat> createState() => _ListChatBody();
}

class _ListChatBody extends State<ListChat> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference chatrooms =
      FirebaseFirestore.instance.collection('ChatRooms');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
          //call all chatroom
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('uid', isEqualTo: currentUser!.uid)
              .snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            var data = snapshot.data!.docs[0];

            return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                itemCount: data['chats'].length,
                itemBuilder: (context, int index) => ChatCard(
                      chatid: data['chats'][index],
                    ));
          }),
    );
  }
}
