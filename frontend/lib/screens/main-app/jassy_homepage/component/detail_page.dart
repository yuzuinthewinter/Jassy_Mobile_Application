import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/screens/main-app/chat/message_screen.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/desc_tabbar.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';

class DetailPage extends StatefulWidget {
  final user;
  final bool isMainPage;
  final Animation animation;

  const DetailPage(
      {Key? key,
      required this.user,
      required this.isMainPage,
      required this.animation})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('ChatRooms');

  final List _LanguageLevelChoicesLists = [
    "Beginner",
    "Elementary",
    "Intermidiate",
    "Upper Intermidiate",
    "Advanced", //advanced
    "Proficiency"
  ];

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
      print(currentTabIndex);
    });
  }

  likeUser(userid) {
    users.doc(currentUser!.uid).update({
      'liked': FieldValue.arrayUnion([userid]),
      'hideUser': FieldValue.arrayUnion([userid]), //cu //like โดย
    });
    users.doc(userid).update({
      'likesby': FieldValue.arrayUnion([currentUser!.uid]),
      'hideUser': FieldValue.arrayUnion([currentUser!.uid]), //like โดย
    });
  }

  createChatRoom(String userid) async {
    var chatMember = [userid, currentUser!.uid];

    if (isHaveRoom) {
      var user = users.where('uid', isEqualTo: userid);
      var snapshot = await user.get();
      final data = snapshot.docs[0];

      var thisUser = users.where('uid', isEqualTo: currentUser!.uid);
      var snapshotUser = await thisUser.get();
      final userData = snapshotUser.docs[0];

      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return ChatRoom(
          chatid: getIdRoom,
          user: data,
          currentUser: userData,
        );
      }));
    } else {
      DocumentReference docRef = await chatRooms.add({
        'member': chatMember,
        'lastMessageSent': '',
        'lastTimestamp': DateTime.now(),
        'unseenCount': 0,
        'sentBy': '',
        'messages': [],
        'type': '',
      });
      await chatRooms.doc(docRef.id).update({
        'chatid': docRef.id,
      });
      await users.doc(chatMember[0]).update({
        'chats': FieldValue.arrayUnion([docRef.id]),
        'hideUser': FieldValue.arrayUnion([chatMember[1]]),
      });
      await users.doc(chatMember[1]).update({
        'chats': FieldValue.arrayUnion([docRef.id]),
        'hideUser': FieldValue.arrayUnion([chatMember[0]]),
      });
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
  }

  bool isHaveRoom = false;
  String getIdRoom = '';
  String getuserid = '';
  checkHaveRoom() async {
    var chatMember = [widget.user['uid'], currentUser!.uid];
    var reverseChatMember = [currentUser!.uid, widget.user['uid']];
    var snap = await chatRooms.get();

    if (snap.docs.isNotEmpty) {
      final chats = snap.docs;
      for (var chat in chats) {
        if (chat['member'].toString() == chatMember.toString() ||
            chat['member'].toString() == reverseChatMember.toString()) {
          isHaveRoom = true;
          getIdRoom = chat['chatid'];
        }
      }
    }
  }

  bool isLoading = true;
  bool isAdmin = false;

  checkStatus() async {
    var snapshot = await users.where('uid', isEqualTo: currentUser!.uid).get();
    if (snapshot.docs.isNotEmpty) {
      final data = await snapshot.docs[0];
      if (data['userStatus'] == 'admin') {
        isAdmin = true;
        isLoading = false;
      } else {
        isAdmin = false;
        isLoading = false;
      }
    }
  }

  @override
  void initState() {
    checkHaveRoom();
    checkStatus();
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      onTabChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.addListener(() {
      onTabChange();
    });

    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).pop();
      }),
      child: Column(
        children: [
          Stack(children: [
            Hero(
              tag: widget.user['profilePic'],
              child: Container(
                width: size.width,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: !widget.user['profilePic'].isEmpty
                            ? NetworkImage(widget.user['profilePic'][0])
                            : const AssetImage("assets/images/header_img1.png")
                                as ImageProvider,
                        fit: BoxFit.cover)),
              ),
            ),
          ]),
          Container(
            color: primaryColor,
            height: size.height * 0.5,
            child: Scaffold(
                body: Container(
              // padding: EdgeInsets.only(top: 20),
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: "kanit",
                                        color: textDark,
                                        fontWeight: FontWeight.w900),
                                    children: [
                                      TextSpan(
                                          text: StringUtils.capitalize(widget
                                                  .user['name']['firstname']) +
                                              ' ' +
                                              StringUtils.capitalize(widget
                                                  .user['name']['lastname'])),
                                      const TextSpan(text: ", "),
                                      TextSpan(
                                          text: calculateAge(DateTime.parse(
                                                  widget.user['birthDate']
                                                      .toString()))
                                              .toString())
                                    ]),
                              ),
                              SizedBox(height: size.height * 0.01),
                              RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: "kanit",
                                        color: greyDark,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: StringUtils.capitalize(
                                              widget.user['country'])),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                            future: checkStatus(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Scaffold(
                                  body: Text('error'),
                                );
                              }
                              return isLoading
                                  ? const SizedBox.shrink()
                                  : isAdmin
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, top: 5),
                                          child: InkWell(
                                              onTap: () {
                                                widget.isMainPage
                                                    ? likeUser(
                                                        widget.user['uid'])
                                                    : createChatRoom(
                                                        widget.user['uid']);
                                              },
                                              child: SvgPicture.asset(widget
                                                      .isMainPage
                                                  ? "assets/icons/heart_button.svg"
                                                  : "assets/icons/ms_button.svg")),
                                        );
                            }),
                      ]),
                  DescTabBar(tabController: tabController),
                  Container(
                    height: size.height * 0.25,
                    // color: greyDark,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 10),
                    child: TabBarView(controller: tabController, children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                // TODO widget.user.motherLanguage
                                child: Text(StringUtils.capitalize(widget
                                    .user['language']['defaultLanguage'])),
                              ),
                              motherLanguageProgressBar(widget.user['language']
                                  ['levelDefaultLanguage']),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                // TODO widget.user.interestLanguage
                                child: Text(StringUtils.capitalize(widget
                                    .user['language']['interestedLanguage'])),
                              ),
                              interestLanguageProgressBar(widget
                                  .user['language']['levelInterestedLanguage']),
                            ],
                          ),
                        ],
                      ),
                      // TODO widget.user.desc
                      Text(StringUtils.capitalize(widget.user['desc']))
                    ]),
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget motherLanguageProgressBar(leveldefault) {
    var size = MediaQuery.of(context).size;
    int level = 0;
    _LanguageLevelChoicesLists.forEachIndexed((index, str) => {
          if (leveldefault.toLowerCase() ==
              _LanguageLevelChoicesLists[index].toLowerCase())
            {
              print(_LanguageLevelChoicesLists[index]),
              level = index + 1,
            }
        });

    return IntervalProgressBar(
        direction: IntervalProgressDirection.horizontal,
        max: 6,
        progress: level,
        intervalSize: 2,
        size: Size(size.width * 0.5, size.height * 0.015),
        highlightColor: primaryColor,
        defaultColor: grey,
        intervalColor: Colors.transparent,
        intervalHighlightColor: Colors.transparent,
        radius: 20);
  }

  Widget interestLanguageProgressBar(levelInt) {
    var size = MediaQuery.of(context).size;
    int level = 0;
    _LanguageLevelChoicesLists.forEachIndexed((index, str) => {
          if (levelInt.toLowerCase() ==
              _LanguageLevelChoicesLists[index].toLowerCase())
            {
              level = index + 1,
            }
        });
    return IntervalProgressBar(
        direction: IntervalProgressDirection.horizontal,
        max: 6,
        progress: level,
        intervalSize: 2,
        size: Size(size.width * 0.5, size.height * 0.015),
        highlightColor: secoundary,
        defaultColor: grey,
        intervalColor: Colors.transparent,
        intervalHighlightColor: Colors.transparent,
        radius: 20);
  }
}
