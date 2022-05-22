// ignore_for_file: deprecated_member_use

import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/admin/request_blocked.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/manage/add_country.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/manage/basic_card.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_card.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_info.dart';
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
class ManageBlockedScreenBody extends StatefulWidget {
  const ManageBlockedScreenBody({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<ManageBlockedScreenBody> createState() => _ManageBlockedScreenBody();
}

class _ManageBlockedScreenBody extends State<ManageBlockedScreenBody> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "การจัดการผู้ใช้งานที่ถูกระงับ"),
      body: Column(children: [
        CurvedWidget(child: JassyGradientColor()),
        SizedBox(
          height: size.height * 0.04,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
          width: size.width,
          height: size.height * 0.06,
          decoration: BoxDecoration(
              color: textLight, borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.drafts_rounded),
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    const Text(
                      "คำร้องขอการกู้คืนบัญชีของผู้ใช้งาน",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: textDark),
                    )
                  ],
                ),onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return const RequestBlocked();
                }));
              },
              ),
            ),
          ]),
        ),
        SizedBox(
          height: size.height * 0.6,
          width: size.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('userStatus', isEqualTo: 'blocked')
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
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                itemCount: data.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.01),
                        width: size.width,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                            color: textLight,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(children: [
                          UserCard(
                            size: size,
                            icon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.verified_rounded),
                              color: data[index]['isAuth'] == true
                                  ? greyLight
                                  : textLight,
                            ),
                            text:
                                '${StringUtils.capitalize(data[index]['name']['firstname'])} ${StringUtils.capitalize(data[index]['name']['lastname'])}',
                            onTab: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    UserInfoPage(data[index]),
                              );
                            },
                            reportIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.verified_rounded),
                              color: textLight,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
