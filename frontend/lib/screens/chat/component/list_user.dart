import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/chat/message_screen.dart';
import 'package:flutter_application_1/theme/index.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
// TODO: map profile image, name and lastest message here
class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  State<ListUser> createState() => _ListUserBody();
}

class _ListUserBody extends State<ListUser> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * 0.16,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('uid', isNotEqualTo: currentUser!.uid)
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          var user = snapshot.data?.docs;

          if (user!.isEmpty) {
            return const Center(
              child: Text('Let\'s talk with the stranger!'),
            );
          } else {
            int count = 0;
            for (var doc in user) {
              if (doc['isActive'] == true) count += 1;
            }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: user.length,
                itemBuilder: (context, int index) => SizedBox(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            // NOTE: click each card to go to chat room
                            return ChatRoom(
                              user: user[index],
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        user[index]['profilePic'].isEmpty
                                            ? "assets/images/header_img1.png"
                                            : user[index]['profilePic'][0]),
                                    radius: 33,
                                  ),
                                  count > 0 && user[index]['isActive'] == true
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
                              SizedBox(
                                width: 70.0,
                                child: Text(
                                  user[index]['name']['firstname'] +
                                      ' ' +
                                      user[index]['name']['lastname'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
          }
        },
      ),
    );
  }
}
