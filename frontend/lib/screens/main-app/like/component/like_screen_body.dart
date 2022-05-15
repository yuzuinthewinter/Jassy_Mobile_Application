import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/main-app/chat/message_screen.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/detail_page.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LikeScreenBody extends StatefulWidget {
  const LikeScreenBody({Key? key}) : super(key: key);

  @override
  State<LikeScreenBody> createState() => _LikeScreenBodyState();
}

class _LikeScreenBodyState extends State<LikeScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  // Todo: infinite scroll
  // bool isLoading = true;
  // bool allLoaded = false;
  // int limit = 2;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('ChatRooms');

  createChatRoom(String userid) async {
    var chatMember = [userid, currentUser!.uid];
    await users.doc(userid).update({
      'likesby': FieldValue.arrayRemove([currentUser!.uid]),
      'liked': FieldValue.arrayRemove([currentUser!.uid]),
    });
    await users.doc(currentUser!.uid).update({
      'likesby': FieldValue.arrayRemove([userid]),
      'liked': FieldValue.arrayRemove([userid]),
    });

    DocumentReference docRef = await chatRooms.add({
      'member': chatMember,
      'lastMessageSent': '',
      'lastTimestamp': DateTime.now(),
      'unseenCount': 0,
      'messages': [],
    });
    await chatRooms.doc(docRef.id).update({
      'chatid': docRef.id,
    });
    for (var member in chatMember) {
      await users.doc(member).update({
        'chats': FieldValue.arrayUnion([docRef.id]),
      });
    }
    var user = users.where('uid', isEqualTo: userid);
    var snapshot = await user.get();
    final data = snapshot.docs[0];

    var thisUser = users.where('uid', isEqualTo: currentUser!.uid);
    var snapshotUser = await thisUser.get();
    final userData = snapshotUser.docs[0];

    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      // NOTE: click each card to go to chat room
      return ChatRoom(
        chatid: docRef.id,
        user: data,
        currentUser: userData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Expanded(
          child: Column(children: [
            StreamBuilder<QuerySnapshot>(
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
                  return GridView.builder(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: size.width / size.height / 0.75,
                          crossAxisCount: 2),
                      itemCount: user[0]['likesby'].length,
                      itemBuilder: (context, index) {
                        return gridViewCard(user[0]['likesby'][index]);
                      });
                })
          ]),
        ),
        const CurvedWidget(child: JassyGradientColor()),
      ],
    );
  }

  Widget gridViewCard(user) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('uid', isEqualTo: user)
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text(' '));
          }
          List<dynamic> snap = snapshot.data!.docs;
          var user = snap[0];
          return GestureDetector(
            onTap: (() {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0, 0.5),
                );
                return FadeTransition(
                  opacity: curvedAnimation,
                  child: DetailPage(user: user, animation: animation),
                );
              }));
              print("each card");
            }),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Hero(
                    tag: user['profilePic'],
                    child: Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: !user['profilePic'].isEmpty
                                  ? NetworkImage(user['profilePic'][0])
                                  : const AssetImage("assets/images/user3.jpg")
                                      as ImageProvider,
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {
                                print("x");
                              },
                              child: SvgPicture.asset(
                                "assets/icons/close_circle.svg",
                                width: size.width * 0.05,
                              )))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: size.height * 0.08,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 8,
                                            fontFamily: "kanit",
                                            fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(text: user['country']),
                                          const TextSpan(text: ", "),
                                          TextSpan(text: user['country']),
                                          const TextSpan(text: " "),
                                          TextSpan(text: user['country'])
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: "kanit",
                                            fontWeight: FontWeight.w900),
                                        children: [
                                          TextSpan(
                                              text: StringUtils.capitalize(user['name']['firstname'])),
                                          const TextSpan(text: ", "),
                                          TextSpan(
                                              text: calculateAge(DateTime.parse(
                                                      user['birthDate']
                                                          .toString()))
                                                  .toString())
                                        ]),
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontFamily: "kanit",
                                            fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(text: "TH"),
                                          WidgetSpan(
                                              child: Icon(
                                            Icons.sync_alt,
                                            size: 10,
                                            color: textLight,
                                          )),
                                          TextSpan(text: "KR"),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            // Todo: wait for chat icon
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                  onTap: () {
                                    createChatRoom(user['uid'].toString());
                                  },
                                  child: Expanded(
                                      child: SvgPicture.asset(
                                    "assets/icons/heart_button.svg",
                                    width: size.width * 0.12,
                                  ))),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
