import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/main-app/chat/message_screen.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:intl/intl.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
// TODO: map profile image, name and lastest message here
class ChatCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final chatid;
  final currentUser;

  const ChatCard({
    Key? key,
    required this.chatid,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardBody();
}

class _ChatCardBody extends State<ChatCard> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('ChatRooms');

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(''),
          );
        }
        var chat = snapshot.data!.docs[0];
        if (chat['member'].length >= 1) {
          for (var memberId in chat['member']) {
            if (memberId != currentUser!.uid) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .where('uid', isEqualTo: memberId)
                    .snapshots(includeMetadataChanges: true),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(''),
                    );
                  }
                  var data = snapshot.data!.docs;
                  for (var user in data) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          // NOTE: click each card to go to chat room
                          return ChatRoom(
                            chatid: chat['chatid'],
                            user: user,
                            currentUser: widget.currentUser,
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: !user['profilePic'].isEmpty
                                      ? NetworkImage(user['profilePic'][0])
                                      : const AssetImage(
                                              "assets/images/header_img1.png")
                                          as ImageProvider,
                                  radius: 33,
                                ),
                                user['isActive'] == true &&
                                        user['isShowActive'] == true &&
                                        widget.currentUser['isShowActive'] ==
                                            true
                                    ? Positioned(
                                        right: 3,
                                        bottom: 3,
                                        child: Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                              color: onlineColor,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor)),
                                        ),
                                      )
                                    : const Text(''),
                              ],
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText(
                                    text: user['name']['firstname'].toString() +
                                        ' ' +
                                        user['name']['lastname'].toString()),
                                DescriptionText(
                                  text: chat['lastMessageSent'].toString(),
                                )
                              ],
                            )),
                            Text(
                              // chat['lastTimestamp']
                              getDate(chat['lastTimestamp']),
                              style: const TextStyle(
                                  fontSize: 12, color: greyDark),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const Text('Let\'s exchange with the expert!');
                },
              );
            }
          }
        }
        return const Text('Let\'s exchange with the expert!');
      },
    );
  }
}
