import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// news card in group
Widget groupNewsCard(postid, context) {
  var size = MediaQuery.of(context).size;

  getDifferance(timestamp) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
    Duration diff = date.difference(lastActive);

    String formattedHour = DateFormat('KK:mm:a').format(lastActive);
    String formattedDay = DateFormat('EEE, d/M').format(lastActive);
    String formattedDaywithyear = DateFormat('EEE, d/M/y').format(lastActive);

    var timeDay = diff.inDays;
    if (timeDay < 1) {
      return '${'GroupPostToday'.tr}, $formattedHour';
    } else if (timeDay < 2) {
      return '${'GroupPostYesterday'.tr}, $formattedHour';
    } else if (timeDay < 365) {
      return formattedDay;
    } else {
      return formattedDaywithyear;
    }
  }

  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('Posts')
        .where('postid', isEqualTo: postid)
        .snapshots(includeMetadataChanges: true),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Text('Something went wrong');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox.shrink();
      }
      if (snapshot.data!.docs.isEmpty) {
        return const SizedBox.shrink();
      }
      var post = snapshot.data!.docs[0];
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('uid', isEqualTo: post['postby'])
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          if (snapshot.data!.docs.isEmpty) {
            return const SizedBox.shrink();
          }
          var user = snapshot.data!.docs[0];
          return Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            decoration: BoxDecoration(
                color: textLight,
                border: Border(
                    bottom: BorderSide(
                        width: size.width * 0.01, color: primaryLightest))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: !user['profilePic'].isEmpty
                            ? NetworkImage(user['profilePic'][0])
                            : const AssetImage("assets/images/user3.png")
                                as ImageProvider,
                        radius: size.width * 0.08,
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.007,
                            ),
                            Text(
                              '${StringUtils.capitalize(user['name']['firstname'])} ${StringUtils.capitalize(user['name']['lastname'])}',
                              style: TextStyle(fontSize: 18, color: textDark),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // post by
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: greyDark,
                                      fontSize: 14,
                                      fontFamily: 'kanit'),
                                  children: [
                                    TextSpan(text: getDifferance(post['date'])),
                                  ]),
                            ),
                          ],
                        ),
                      )),
                      Icon(
                        Icons.more_horiz,
                        color: primaryColor,
                        size: size.width * 0.08,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                // post text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Container(
                      constraints:
                          const BoxConstraints(maxHeight: double.infinity),
                      child: Column(
                        children: [
                          Text(
                            post['text'],
                            maxLines: null,
                            style: TextStyle(fontSize: 16),
                          ),
                          post['picture'].isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    width: size.width * 0.5,
                                    height: size.height * 0.3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(post['picture']),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      )),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                // like and comment icon
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Row(
                    children: [
                      LikeButtonWidget(post, user['uid']),
                      SizedBox(width: size.width * 0.05),
                      InkWell(
                          onTap: () {
                            // FocusScope.of(context).requestFocus(myFocusNode);
                          },
                          child: SvgPicture.asset(
                            "assets/icons/comment_icon.svg",
                            width: size.width * 0.07,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
