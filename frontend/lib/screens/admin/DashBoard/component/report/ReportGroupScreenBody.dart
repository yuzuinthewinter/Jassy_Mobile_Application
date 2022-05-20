// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/report/reportpost_info.dart';
import 'package:flutter_application_1/theme/index.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
class ReportGroupScreenBody extends StatefulWidget {
  const ReportGroupScreenBody({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<ReportGroupScreenBody> createState() => _ReportGroupScreenBody();
}

class _ReportGroupScreenBody extends State<ReportGroupScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      CurvedWidget(child: JassyGradientColor()),
      SizedBox(
        height: size.height * 0.04,
      ),
      SizedBox(
        height: size.height * 0.6,
        width: size.width,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('ReportPost')
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
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                              color: textLight,
                              borderRadius: BorderRadius.circular(15)),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Posts')
                                  .where('postid',
                                      isEqualTo: data[index]['postid'])
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
                                var post = snapshot.data!.docs[0];
                                return Column(children: [
                                  MenuCard(
                                    size: size,
                                    icon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.insert_comment_rounded),
                                      color: post['reported'].length > 5
                                          ? textMadatory
                                          : tertiary,
                                    ),
                                    text: data[index]['reportHeader'],
                                    onTab: () {
                                      Navigator.push(context,
                                          CupertinoPageRoute(
                                              builder: (context) {
                                        return ReportPostInfoPage(data[index]);
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
                  });
            }),
      ),
    ]);
  }
}
