import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  getDate(timestamp) {
    DateTime datatime = DateTime.parse(timestamp.toDate().toString());
    String formattedTime = DateFormat('kk:mm:a').format(datatime);
    return formattedTime.toString();
  }

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
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        var data = snapshot.data!.docs;
        if (data.isEmpty) {
          return Center(child: Text(data.toString()));
        }
        if (data[0]['messages'].isEmpty) {
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
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text(' '));
        }
        List<dynamic> snap = snapshot.data!.docs;
        var currentMessage = snap[0];
        var sender = currentMessage['sentBy'];
        bool isCurrentUser = sender == currentUser!.uid;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text(currentMessage['message']),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
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
                    getDate(currentMessage['time']).toString(),
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
