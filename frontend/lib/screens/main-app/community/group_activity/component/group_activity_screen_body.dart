import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/group_news_widget.dart';
import 'package:flutter_application_1/screens/main-app/community/my_group/my_group.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../post_detail.dart';

class GroupActivityScreenBody extends StatefulWidget {
  final groupActivity;
  final user;

  const GroupActivityScreenBody(
      {Key? key, required this.groupActivity, required this.user})
      : super(key: key);

  @override
  State<GroupActivityScreenBody> createState() =>
      _GroupActivityScreenBodyState();
}

class _GroupActivityScreenBodyState extends State<GroupActivityScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference community =
      FirebaseFirestore.instance.collection('Community');

  joinGroup() async {
    await community.doc(widget.groupActivity['groupid']).update({
      'membersID': FieldValue.arrayUnion([currentUser!.uid]),
    });
    await users.doc(currentUser!.uid).update({
      'groups': FieldValue.arrayUnion([widget.groupActivity['groupid']]),
    });
    Navigator.of(context).pop();
  }

  bool isMember = false;
  Widget getButtonJoinGroup(size) {
    for (var groupid in widget.user['groups']) {
      if (groupid == widget.groupActivity['groupid']) {
        isMember = true;
      }
    }
    return isMember == true
        ? const SizedBox.shrink()
        : Center(
            child: RoundButton(
                text: "GroupJoin".tr,
                minimumSize: Size(size.width * 0.8, size.height * 0.05),
                press: () {
                  joinGroup();
                }),
          );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CurvedWidget(
            child: JassyGradientColor(
          gradientHeight: size.height * 0.23,
        )),
        getButtonJoinGroup(size),
        SizedBox(
          height: size.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: textDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'kanit'),
                  children: [
                WidgetSpan(
                    child: SvgPicture.asset("assets/icons/group_activity.svg")),
                WidgetSpan(
                  child: SizedBox(
                    width: size.width * 0.01,
                  ),
                ),
                TextSpan(text: "GroupActivity".tr)
              ])),
        ),
        Expanded(
          child: ListView.separated(
              padding: EdgeInsets.only(top: size.height * 0.02),
              scrollDirection: Axis.vertical,
              itemCount: widget.groupActivity['postsID'].length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: size.height * 0.03,
                );
              },
              itemBuilder: (context, index) {
                int reversedindex =
                    widget.groupActivity['postsID'].length - 1 - index;
                // list of news card in group
                return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                        return PostDetail(
                          post: widget.groupActivity['postsID'][reversedindex],
                        );
                      }));
                    },
                    child: groupNewsCard(
                        widget.groupActivity['postsID'][reversedindex],
                        context));
              }),
        ),
      ],
    );
  }
}
