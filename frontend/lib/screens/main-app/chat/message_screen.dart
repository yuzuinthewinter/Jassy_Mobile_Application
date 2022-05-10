import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/text/report_choice.dart';
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

class _ChatRoomState extends State<ChatRoom> {
  bool isNotificationOn = true;

  getDifferance(timestamp) {
    DateTime now = DateTime.now();
    DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
    Duration diff = now.difference(lastActive);
    var timeMin = diff.inMinutes;
    var timeHour = diff.inHours;
    var timeDay = diff.inDays;
    if (timeMin < 3) {
      return 'StatusActiveAfew'.tr;
    } else if (timeMin < 60) {
      return '${'StatusActive'.tr} ${timeMin.toString()} ${'StatusActiveMins'.tr}';
    } else if (timeHour < 24) {
      return '${'StatusActive'.tr} ${timeHour.toString()}${'StatusActiveHours'.tr}';
    } else if (timeDay < 3) {
      return '${'StatusActive'.tr} ${timeDay.toString()}${'StatusActiveDays'.tr}';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            // Note: map chat room name on appbar here
            Text(
              widget.user['name']['firstname'].toString() +
                  ' ' +
                  widget.user['name']['lastname'].toString(),
              style: const TextStyle(fontSize: 16, color: textDark),
            ),
            widget.user['reportCount'] < 3
                ? widget.user['isShowActive'] &&
                        widget.currentUser['isShowActive']
                    ? Text(
                        widget.user['isActive']
                            ? 'StatusActiveNow'.tr
                            : getDifferance(widget.user['timeStamp']),
                        style: const TextStyle(fontSize: 14, color: greyDark),
                      )
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone),
            color: primaryDarker,
          ),
          PopupMenuButton<MenuItem>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onSelected: (value) => {
              if (value == MenuItem.item1)
                {
                  print("turn off notification"),
                  _toggleNotification,
                  print(isNotificationOn)
                }
              else if (value == MenuItem.item2)
                {print("cancel pairing")}
              else if (value == MenuItem.item3)
                {reportModalBottomSheet(context), print('report')}
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: MenuItem.item1,
                  onTap: () {
                    print(isNotificationOn);
                    _toggleNotification;
                  },
                  child: Row(
                    children: [
                      isNotificationOn
                          ? SvgPicture.asset("assets/icons/notification_on.svg")
                          : SvgPicture.asset(
                              "assets/icons/notification_off.svg"),
                      isNotificationOn
                          ? Text("MenuNotificationOn".tr)
                          : Text("MenuNotificationOff".tr),
                    ],
                  )),
              PopupMenuItem(
                  value: MenuItem.item2,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/cancel_pairing.svg"),
                      Text("MenuUnmatch".tr),
                    ],
                  )),
              PopupMenuItem(
                  value: MenuItem.item3,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/report.svg"),
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
        chatid: widget.chatid,
      ),
    );
  }

  void _toggleNotification() {
    setState(() {
      isNotificationOn = !isNotificationOn;
    });
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
                    style: TextStyle(fontSize: 16),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "ReportChoose".tr,
                        style: TextStyle(fontSize: 16),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                    child: Text(
                      "ReportDesc".tr,
                      style: TextStyle(fontSize: 14, color: greyDark),
                    ),
                  ),
                  ReportTypeChoice(
                    text: 'ReportNudity'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportVio'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportThreat'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportProfan'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportTerro'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportChild'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportSexual'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportAnimal'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportScam'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportAbuse'.tr,
                  ),
                  ReportTypeChoice(
                    text: 'ReportOther'.tr,
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
