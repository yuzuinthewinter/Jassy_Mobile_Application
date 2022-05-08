// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/popup_no_button/success_popup_no_button.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/success_popup_with_button.dart';
import 'package:flutter_application_1/component/popup_page/successWithButton.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_card.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_info.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
  bool isToggleShowUser = false;

  getDifferance(timestamp) {
    DateTime now = DateTime.now();
    DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
    Duration diff = now.difference(lastActive);
    var timeMin = diff.inMinutes;
    var timeHour = diff.inHours;
    var timeDay = diff.inDays;
    if (timeMin < 3) {
      return 'Active a few minutes ago';
    } else if (timeMin < 60) {
      return 'Active ${timeMin.toString()} minutes ago';
    } else if (timeHour < 24) {
      return 'Active ${timeHour.toString()}h ago';
    } else if (timeDay < 3) {
      return 'Active ${timeDay.toString()}d ago';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          child: TextFormField(
            // controller: passwordController,
            // obscureText: isHiddenPassword,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                'assets/icons/search.svg',
                height: 16,
              ),
              hintText: 'ค้นหา',
              filled: true,
              fillColor: textLight,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.6,
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
                    return Column(children: [
                      Container(
                        // margin:
                        // EdgeInsets.symmetric(horizontal: size.width * 0.13),
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
                                  ? data[index]['reportCount'] < 5
                                      ? primaryColor
                                      : greyDark
                                  : textLight,
                            ),
                            text: data[index]['name']['firstname'].toString() ==
                                        '' &&
                                    data[index]['name']['lastname']
                                            .toString() ==
                                        ''
                                ? '-'
                                : '${data[index]['name']['firstname'].toString()} ${data[index]['name']['lastname'].toString()}',
                            reportIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(data[index]['reportCount'] < 5
                                  ? Icons.report_problem_rounded
                                  : Icons.cancel_rounded),
                              color: data[index]['reportCount'] < 3
                                  ? textLight
                                  : data[index]['reportCount'] < 5
                                      ? tertiary
                                      : textLight,
                            ),
                            onTab: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    UserInfoPage(data[index]),
                              );
                            },
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                    ]
                        // Text(data[index]['name'].toString());
                        );
                  });
            },
          ),
        ),
      ],
    );
  }
}
