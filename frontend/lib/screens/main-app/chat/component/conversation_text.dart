import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/demo_chat_message.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:intl/intl.dart';

class ConversationText extends StatefulWidget {
  final chatid;
  final user;

  const ConversationText({
    Key? key,
    required this.user,
    required this.chatid,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<ConversationText> {
  CollectionReference chat = FirebaseFirestore.instance.collection('ChatRooms');
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ChatRooms')
          .where('chatid', isEqualTo: widget.chatid)
          .snapshots(includeMetadataChanges: true),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(' '),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs[0]['messages'].length == 0) {
          return const Center(child: Text('Let\'s start conversation'));
        }
        return ListView.builder(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.docs[0]['messages'].length,
          itemBuilder: (context, index) {
            int reversedIndex =
                snapshot.data!.docs[0]['messages'].length - 1 - index;
            final messageid = snapshot.data!.docs[0]['messages'][reversedIndex];
            return getMessage(messageid);
          },
        );
      },
    );
  }

  Widget getMessage(messageid) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Messages')
          .where('messageID', isEqualTo: messageid)
          .snapshots(includeMetadataChanges: true),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(' '),
          );
        }
        if (snapshot.data!.docs[0]['message'] == null) {
          return const Center(child: Text(' '));
        }
        var currentMessage = snapshot.data!.docs[0];
        var sender = currentMessage['sentBy'];
        bool isCurrentUser = sender == currentUser!.uid;

        int ts = currentMessage['time'].millisecondsSinceEpoch;
        DateTime tsdate = DateTime.fromMicrosecondsSinceEpoch(ts);
        String formatTime = DateFormat.jm().format(tsdate);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text(currentMessage['message']),
              Row(
                mainAxisAlignment: isCurrentUser
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      if (!isCurrentUser) ...[
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: !widget.user['profilePic'].isEmpty
                              ? NetworkImage(widget.user['profilePic'][0])
                              : const AssetImage(
                                      "assets/images/header_img1.png")
                                  as ImageProvider,
                        ),
                        SizedBox(
                          width: size.height * 0.06,
                        ),
                      ],
                      if (isCurrentUser) ...[
                        const Text(
                          "อ่านแล้ว",
                          style: TextStyle(color: grey, fontSize: 12),
                        ),
                        SizedBox(
                          width: size.height * 0.06,
                        ),
                      ]
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: isCurrentUser ? primaryLighter : textLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(currentMessage['message'])),
                ],
              ),
              Row(
                mainAxisAlignment: isCurrentUser
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  if (!isCurrentUser)
                    SizedBox(
                      width: size.height * 0.06,
                    ),
                  Text(
                    formatTime.toString(),
                    style: const TextStyle(color: grey, fontSize: 12),
                  ),
                  SizedBox(
                    width: size.height * 0.01,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
