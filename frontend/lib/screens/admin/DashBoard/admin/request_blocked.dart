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
import 'package:flutter_application_1/screens/admin/DashBoard/admin/request_blocked_detail.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/suggestion_detail_screen.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/manage/add_country.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/manage/basic_card.dart';
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
class RequestBlocked extends StatefulWidget {
  const RequestBlocked({Key? key}) : super(key: key);

  @override
  State<RequestBlocked> createState() => _RequestBlocked();
}

class _RequestBlocked extends State<RequestBlocked> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "คำร้องขอการกู้คืนบัญชีของผู้ใช้งาน"),
      body: Column(children: [
        CurvedWidget(child: JassyGradientColor()),
        SizedBox(
          height: size.height * 0.6,
          width: size.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('SuspendedUser')
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
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('uid', isEqualTo: data[index]['requestBy'])
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
                      var user = snapshot.data!.docs[0];
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.height * 0.01),
                            width: size.width,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                                color: textLight,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(children: [
                              BasicCard(
                                size: size,
                                text:
                                    '${StringUtils.capitalize(user['name']['firstname'])} ${StringUtils.capitalize(user['name']['lastname'])}',
                                onTab: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        RequestDetailPage(data[index], user),
                                  );
                                },
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
              );
            },
          ),
        ),
      ]),
    );
  }
}
