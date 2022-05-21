// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/admin/manage_blocked.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/admin/manage_user.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/suggestion_screen.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/manage/manage_data.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/report/reportGroup.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/report/reportUser.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_card.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
import 'package:flutter_application_1/screens/main-app/chat/message_screen.dart';
import 'package:flutter_application_1/screens/main-app/community/community.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
class DashboardScreenBody extends StatefulWidget {
  const DashboardScreenBody({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<DashboardScreenBody> createState() => _DashboardScreenBody();
}

class _DashboardScreenBody extends State<DashboardScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      CurvedWidget(child: JassyGradientColor()),
       SizedBox(
        height: size.height * 0.03,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
        width: size.width,
        height: size.height * 0.075,
        decoration: BoxDecoration(
            color: textLight, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return SuggestionScreen();
              }));
            },
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.newspaper_rounded),
                  color: primaryColor,
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  "ข้อเสนอแนะจากผู้ใช้งาน",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: textDark),
                ),
                Spacer(),
              ],
            ),
          ))
        ]),
      ),
    SizedBox(
        height: size.height * 0.04,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
        width: size.width,
        height: size.height * 0.22,
        decoration: BoxDecoration(
            color: textLight, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          MenuCard(
            size: size,
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.document_scanner_rounded),
              color: primaryColor,
            ),
            text: 'การจัดการข้อมูลแอปพลิเคชั่น',
            onTab: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return ManageScreenBody();
              }));
            },
          ),
          MenuCard(
            size: size,
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.security),
              color: primaryColor,
            ),
            text: 'การจัดการผู้ดูแลระบบ',
            onTab: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return ManageAdminScreenBody();
              }));
            },
          ),
          MenuCard(
            size: size,
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.people_alt),
              color: primaryColor,
            ),
            text: 'การจัดการกลุ่มชุมชน',
            onTab: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return CommunityScreen();
              }));
            },
          ),
        ]),
      ),
      SizedBox(
        height: size.height * 0.03,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
        width: size.width,
        height: size.height * 0.22,
        decoration: BoxDecoration(
            color: textLight, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return ManageBlockedScreenBody();
              }));
            },
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_off_rounded),
                  color: secoundary,
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  "การจัดการผู้ใช้งานที่ถูกระงับ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: textMadatory),
                ),
                Spacer(),
              ],
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return ReportUserScreen();
              }));
            },
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message_rounded),
                  color: secoundary,
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  "ตรวจสอบคำร้องเรียนผู้ใช้งาน",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: textMadatory),
                ),
                Spacer(),
              ],
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return ReportGroupScreen();
              }));
            },
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.quiz_rounded),
                  color: secoundary,
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  "ตรวจสอบคำร้องเรียนจากชุมชน",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: textMadatory),
                ),
                Spacer(),
              ],
            ),
          ))
        ]),
      ),
      ]);
  }
}
