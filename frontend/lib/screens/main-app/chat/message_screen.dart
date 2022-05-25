import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/component/text/report_choice.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/message_screen_body.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum MenuItem { item1, item2, item3 }

class ChatRoom extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final chatid;
  final user;
  final currentUser;

  const ChatRoom({
    Key? key,
    required this.chatid,
    required this.user,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with WidgetsBindingObserver {
  bool isNotificationOn = true;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference chats =
      FirebaseFirestore.instance.collection('ChatRooms');
  var currentUser = FirebaseAuth.instance.currentUser;

  getDifferance(timestamp) {
    DateTime now = DateTime.now();
    DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
    Duration diff = now.difference(lastActive);
    var timeMin = diff.inMinutes;
    var timeHour = diff.inHours;
    var timeDay = diff.inDays;
    if (timeMin < 3) {
      return Text(
        'StatusActiveAfew'.tr,
        style: const TextStyle(fontSize: 14, color: greyDark),
      );
    } else if (timeMin < 60) {
      return Text(
        '${'StatusActive'.tr} ${timeMin.toString()}${'StatusActiveMins'.tr}',
        style: const TextStyle(fontSize: 14, color: greyDark),
      );
    } else if (timeHour < 24) {
      return Text(
        '${'StatusActive'.tr} ${timeHour.toString()}${'StatusActiveHours'.tr}',
        style: const TextStyle(fontSize: 14, color: greyDark),
      );
    } else if (timeDay < 3) {
      return Text(
        '${'StatusActive'.tr} ${timeDay.toString()}${'StatusActiveDays'.tr}',
        style: const TextStyle(fontSize: 14, color: greyDark),
      );
    } else {
      return Container(height: 1);
    }
  }

  unMatch() async {
    await users.doc(widget.user['uid']).update({
      'chats': FieldValue.arrayRemove([widget.chatid]),
      'likesby': FieldValue.arrayRemove([widget.currentUser['uid']]),
      'liked': FieldValue.arrayRemove([widget.currentUser['uid']]),
    });
    await users.doc(widget.currentUser['uid']).update({
      'chats': FieldValue.arrayRemove([widget.chatid]),
      'likesby': FieldValue.arrayRemove([widget.user['uid']]),
      'liked': FieldValue.arrayRemove([widget.user['uid']]),
    });
    await chats.doc(widget.chatid).delete();
    Navigator.of(context).pushNamed(Routes.JassyHome, arguments: [3, true, false]);
  }

  bool isInRoom = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    isInRoom = true;
    setInRoom(isInRoom);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    isInRoom = false;
    setInRoom(isInRoom);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      if (state == AppLifecycleState.resumed) {
        isInRoom = true;
        setInRoom(isInRoom);
      } else {
        isInRoom = false;
        setInRoom(isInRoom);
      }
    });
  }

  void setInRoom(bool isInRoom) async {
    if (isInRoom == true) {
      await FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(widget.chatid)
          .update({
        'unseenCount': 0,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            // Note: map chat room name on appbar here
            Text(
              StringUtils.capitalize(widget.user['name']['firstname']) +
                  ' ' +
                  StringUtils.capitalize(widget.user['name']['lastname']),
              style: const TextStyle(fontSize: 16, color: textDark),
            ),
            widget.user['report'].length < 3
                ? widget.user['isShowActive'] &&
                        widget.currentUser['isShowActive']
                    ? widget.user['isActive']
                        ? Text(
                            'StatusActiveNow'.tr,
                            style:
                                const TextStyle(fontSize: 14, color: greyDark),
                          )
                        : getDifferance(widget.user['timeStamp'])
                    : Container(
                        height: 1,
                      )
                : Container(height: 1)
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          color: primaryDarker,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          PopupMenuButton<MenuItem>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onSelected: (value) => {
              if (value == MenuItem.item1)
                {
                  print(isNotificationOn),
                  setState(() {
                    isNotificationOn = !isNotificationOn;
                  }),
                  print("turn off notification"),
                  print(isNotificationOn)
                }
              else if (value == MenuItem.item2)
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return WarningPopUpWithButton(
                          text: 'WarningUnmatch'.tr,
                          okPress: () {
                            unMatch();
                          },
                        );
                      })
                }
              else if (value == MenuItem.item3)
                {reportModalBottomSheet(context), print('report')}
            },
            itemBuilder: (context) => [
              // PopupMenuItem(
              //     value: MenuItem.item1,
              //     child: Row(
              //       children: [
              //         isNotificationOn
              //             ? SvgPicture.asset("assets/icons/notification_on.svg")
              //             : SvgPicture.asset(
              //                 "assets/icons/notification_off.svg"),
              //         isNotificationOn
              //             ? Text("MenuNotificationOn".tr)
              //             : Text("MenuNotificationOff".tr),
              //       ],
              //     )),
              PopupMenuItem(
                  value: MenuItem.item2,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/cancel_pairing.svg"),
                      SizedBox(width: size.width * 0.02,),
                      Text("MenuUnmatch".tr),
                    ],
                  )),
              PopupMenuItem(
                  value: MenuItem.item3,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/report.svg"),
                      SizedBox(width: size.width * 0.02,),
                      Text("MenuReport".tr),
                    ],
                  )),
            ],
            icon: const Icon(
              Icons.more_vert,
              color: primaryDarker,
            ),
          )
        ],
      ),
      body: MessageScreenBody(
        user: widget.user,
        currentUser: widget.currentUser,
        chatid: widget.chatid,
        inRoom: isInRoom,
      ),
    );
  }

  Future<dynamic> reportModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.60,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    "MenuReport".tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "ReportChoose".tr,
                        style: const TextStyle(fontSize: 16),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 0.0),
                    child: Text(
                      "ReportDesc".tr,
                      style: const TextStyle(fontSize: 14, color: greyDark),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ReportTypeChoice(
                            text: 'ReportNudity'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportVio'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportThreat'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportProfan'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportTerro'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportChild'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportSexual'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportAnimal'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportScam'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportAbuse'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                          ReportTypeChoice(
                            text: 'ReportOther'.tr,
                            userid: widget.user['uid'],
                            chatid: widget.chatid,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("รายงาน", style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                  //     // Spacer(),
                  //     IconButton(onPressed: () { Navigator.pop(context); }, icon: SvgPicture.asset("assets/icons/close_icon.svg"),)
                  //   ],
                  // )
                ],
              ),
            ));
  }
}
