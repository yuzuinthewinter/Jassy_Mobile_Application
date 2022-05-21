import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/noaction_appbar.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/dash_screen_body.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/report/ReportUserScreen.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/report/reportuser_info.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_body.dart';
import 'package:flutter_application_1/theme/index.dart';

class ListReportUserScreen extends StatelessWidget {
  final user;
  const ListReportUserScreen(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
          text:
              '${StringUtils.capitalize(user['name']['firstname'])} ${StringUtils.capitalize(user['name']['lastname'])}'),
      body: Column(children: [
        CurvedWidget(child: JassyGradientColor()),
        SizedBox(
          height: size.height * 0.02,
        ),
        SizedBox(
          height: size.height * 0.6,
          width: size.width,
          child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              itemCount: user['report'].length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.height * 0.01),
                      width: size.width,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                          color: textLight,
                          borderRadius: BorderRadius.circular(15)),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('ReportUser')
                              .where('reportUserId', isEqualTo: user['uid'])
                              .snapshots(includeMetadataChanges: true),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text(''),
                              );
                            }
                            var data = snapshot.data!.docs[0];
                            return Column(children: [
                              MenuCard(
                                size: size,
                                icon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.person_rounded),
                                  color: user['report'].length > 5
                                      ? textMadatory
                                      : tertiary,
                                ),
                                text: data['reportHeader'],
                                onTab: () {
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return ReportUserInfoPage(user, data);
                                  }));
                                },
                              ),
                            ]);
                          }),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                  ],
                );
              }),
        ),
      ]),
    );
  }
}
