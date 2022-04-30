import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/main-app/chat/message_screen.dart';
import 'package:flutter_application_1/theme/index.dart';

class LikeScreenBody extends StatefulWidget {
  const LikeScreenBody({Key? key}) : super(key: key);

  @override
  State<LikeScreenBody> createState() => _LikeScreenBody();
}

class _LikeScreenBody extends State<LikeScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('ChatRooms');

  createChatRoom(String userid) async {
    var chatMember = [userid, currentUser!.uid];
    var reverse = [currentUser!.uid, userid];

    var queryUser1 = chatRooms.where('member', isEqualTo: chatMember);
    QuerySnapshot querySnapshot1 = await queryUser1.get();
    final allData1 = querySnapshot1.docs.map((doc) => doc.data()).toList();

    var queryUser2 = chatRooms.where('member', isEqualTo: reverse);
    QuerySnapshot querySnapshot2 = await queryUser2.get();
    final allData2 = querySnapshot2.docs.map((doc) => doc.data()).toList();

    if (allData1.isEmpty && allData2.isEmpty) {
      DocumentReference docRef = await chatRooms.add({
        'member': chatMember,
        'lastMessageSent': '',
        'lastTimestamp': '',
        'unseenCount': 0,
      });
      await chatRooms.doc(docRef.id).update({
        'chatid': docRef.id,
      });
      for (var member in chatMember) {
        await users.doc(member).update({
          'chats': FieldValue.arrayUnion([docRef.id]),
        });
      }
    } else {
      var user = users.where('uid', isEqualTo: userid);
      var snapshot = await user.get();
      final data = snapshot.docs[0];

      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        // NOTE: click each card to go to chat room
        return ChatRoom(
          user: data,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.7,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('uid', isEqualTo: currentUser!.uid)
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
              if (snapshot.data!.docs[0]['likesby'].length == 0) {
                return const Center(
                    child: Text('Someone who likes you will show here'));
              }
              var user = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: user[0]['likesby'].length,
                  itemBuilder: (context, int index) =>
                      showLikeByList(user[0]['likesby'][index]));
            },
          ),
        ),
      ],
    );
  }

  Widget showLikeByList(user) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: user)
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
        var user = snapshot.data!.docs[0];
        return SizedBox(
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: !user['profilePic'].isEmpty
                            ? NetworkImage(user['profilePic'][0])
                            : const AssetImage("assets/images/header_img1.png")
                                as ImageProvider,
                        radius: 33,
                      ),
                      user['isActive'] == true
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
                            text: user['name']['firstname'] +
                                ' ' +
                                user['name']['lastname']),
                      ],
                    ),
                  ),
                  RoundButton(
                    text: 'Messages',
                    minimumSize: const Size(36, 12),
                    press: () {
                      createChatRoom(user['uid'].toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}