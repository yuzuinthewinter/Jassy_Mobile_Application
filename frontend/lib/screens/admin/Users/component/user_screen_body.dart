// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:intl/intl.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
class UserScreenBody extends StatefulWidget {
  const UserScreenBody({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<UserScreenBody> createState() => _UserScreenBody();
}

class _UserScreenBody extends State<UserScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  getDifferance(timestamp) {
    DateTime now = DateTime.now();
    DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
    Duration diff = now.difference(lastActive);
    var timeMin = diff.inMinutes;
    var timeHour = diff.inHours;
    if (diff.inMinutes < 3) {
      return 'Active a few minutes ago';
    } else if (diff.inMinutes < 60) {
      return 'Active ${timeMin.toString()} minutes ago';
    } else {
      return 'Active ${timeHour.toString()}h ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.2,
        ),
        Container(
          height: size.height * 0.5,
          width: size.width,
          child: StreamBuilder<QuerySnapshot>(
            //call all user
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('userStatus', isEqualTo: 'user')
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text(''));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  var data = snapshot.data!.docs;
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context,
                      // CupertinoPageRoute(builder: (context) {
                      // NOTE: click each card to go to chat room
                      // return ChatRoom(
                      //   chatid: chat['chatid'],
                      //   user: user,
                      // );
                      // }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: !data[index]['profilePic']
                                        .isEmpty
                                    ? NetworkImage(data[index]['profilePic'][0])
                                    : const AssetImage(
                                            "assets/images/header_img1.png")
                                        as ImageProvider,
                                radius: 33,
                              ),
                              data[index]['isActive'] == true
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
                                  text: data[index]['name']['firstname']
                                          .toString() +
                                      ' ' +
                                      data[index]['name']['lastname']
                                          .toString()),
                              DescriptionText(
                                text: getDifferance(data[index]['timeStamp']),
                              )
                            ],
                          )),
                          // Text(
                          //   // chat['lastTimestamp']
                          //   getDifferance(data[index]['timeStamp']),
                          //   style:
                          //       const TextStyle(fontSize: 12, color: greyDark),
                          // )
                        ],
                      ),
                    ),
                  );
                  // Text(data[index]['name'].toString());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
