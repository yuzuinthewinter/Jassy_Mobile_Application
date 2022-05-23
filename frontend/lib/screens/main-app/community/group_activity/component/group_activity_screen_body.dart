import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/component/report_post.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    Navigator.of(context)
        .pushNamed(Routes.JassyHome, arguments: [2, true, false]);
  }

  bool isNotificationOn = false;
  bool isSavedPost = false;

  bool isMember = false;
  Widget getButtonJoinGroup(size) {
    for (var groupid in widget.user['groups']) {
      if (groupid == widget.groupActivity['groupid']) {
        isMember = true;
      }
    }
    return widget.user['userStatus'] == 'admin'
        ? const SizedBox.shrink()
        : isMember == true
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
          //TODO: use stream
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
                      isMember == false
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return WarningPopUpWithButton(
                                  text: 'GroupActivity'.tr,
                                  okPress: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              })
                          : Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                              return PostDetail(
                                postid: widget.groupActivity['postsID']
                                    [reversedindex],
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

    CollectionReference savePosts =
        FirebaseFirestore.instance.collection('SavePosts');
    savePost(post) async {
      var queryPost = savePosts.where('savedBy', isEqualTo: currentUser!.uid);
      QuerySnapshot querySnapshot = await queryPost.get();
      if (querySnapshot.docs.isNotEmpty) {
        await savePosts.doc(currentUser!.uid).update({
          'savedBy': widget.user['uid'],
          'saved': FieldValue.arrayUnion([post['postid']])
        });
      } else {
        await savePosts.doc(currentUser!.uid).set({
          'savedBy': widget.user['uid'],
          'saved': FieldValue.arrayUnion([post['postid']])
        });
      }
    }

    unsavePost(post) async {
      await savePosts.doc(currentUser!.uid).update({
        'saved': FieldValue.arrayRemove([post['postid']]),
      });
    }

    deletePost(post) async {
      CollectionReference posts =
          FirebaseFirestore.instance.collection('Posts');
      CollectionReference groups =
          FirebaseFirestore.instance.collection('Community');
      await posts.doc(post['postid']).delete();
      await groups.doc(post['groupid']).update({
        'postsID': FieldValue.arrayRemove([post['postid']]),
      });
      Navigator.of(context).pop();
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
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: !user['profilePic'].isEmpty
                              ? NetworkImage(user['profilePic'][0])
                              : const AssetImage("assets/images/user3.jpg")
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
                                      TextSpan(
                                          text: getDifferance(post['date'])),
                                    ]),
                              ),
                            ],
                          ),
                        )),
                        isMember == false
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: widget.user['userStatus'] ==
                                                  'admin'
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.12
                                              : post['postby'] ==
                                                      widget.user['uid']
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                          padding: const EdgeInsets.only(
                                              top: 5.0,
                                              left: 20.0,
                                              right: 20,
                                              bottom: 15),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.02),
                                                child: Column(
                                                  children: [
                                                    widget.user['userStatus'] ==
                                                            'admin'
                                                        ? const SizedBox
                                                            .shrink()
                                                        : isSavedPost == false
                                                            ? Expanded(
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                    setState(
                                                                        () {
                                                                      isSavedPost =
                                                                          true;
                                                                    });
                                                                    await savePost(
                                                                        post);
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/saved_lists.svg"),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.03,
                                                                      ),
                                                                      const Text(
                                                                          "บันทึกโพสต์")
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Expanded(
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                    setState(
                                                                        () {
                                                                      isSavedPost =
                                                                          false;
                                                                    });
                                                                    await unsavePost(
                                                                        post);
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/unsaved_list.svg"),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.03,
                                                                      ),
                                                                      const Text(
                                                                          "เลิกบันทึกโพสต์")
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                    widget.user['userStatus'] ==
                                                            'admin'
                                                        ? const SizedBox
                                                            .shrink() //TODO: report list
                                                        : post['postby'] !=
                                                                widget
                                                                    .user['uid']
                                                            ? Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    // Todo: Report
                                                                    reportModalBottomSheet(
                                                                        context,
                                                                        widget
                                                                            .user,
                                                                        post[
                                                                            'postid']);
                                                                    // line 613
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/report.svg"),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.03,
                                                                      ),
                                                                      Text("GroupPostReport"
                                                                          .tr)
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                    widget.user['userStatus'] ==
                                                            'admin'
                                                        ? Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return WarningPopUpWithButton(
                                                                        text: 'GroupDeleteWarning'
                                                                            .tr,
                                                                        okPress:
                                                                            () {
                                                                          deletePost(
                                                                              post);
                                                                        },
                                                                      );
                                                                    });
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      "assets/icons/del_bin_circle.svg"),
                                                                  SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.03,
                                                                  ),
                                                                  Text(
                                                                      "GroupPostDelete"
                                                                          .tr)
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : post['postby'] ==
                                                                widget
                                                                    .user['uid']
                                                            ? Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return WarningPopUpWithButton(
                                                                            text:
                                                                                'GroupDeleteWarning'.tr,
                                                                            okPress:
                                                                                () {
                                                                              deletePost(post);
                                                                            },
                                                                          );
                                                                        });
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/del_bin_circle.svg"),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.03,
                                                                      ),
                                                                      Text("GroupPostDelete"
                                                                          .tr)
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                    widget.user['userStatus'] ==
                                                            'admin'
                                                        ? const SizedBox
                                                            .shrink()
                                                        : const SizedBox
                                                            .shrink()
                                                    // Expanded(
                                                    //     child: InkWell(
                                                    //       onTap: () {
                                                    //         Navigator.pop(
                                                    //             context);
                                                    //         setState(() {
                                                    //           isNotificationOn =
                                                    //               !isNotificationOn;
                                                    //         });
                                                    //       },
                                                    //       child: Row(
                                                    //         children: [
                                                    //           isNotificationOn
                                                    //               ? SvgPicture
                                                    //                   .asset(
                                                    //                       "assets/icons/notification_off.svg")
                                                    //               : SvgPicture
                                                    //                   .asset(
                                                    //                       "assets/icons/notification_on.svg"),
                                                    //           SizedBox(
                                                    //             width:
                                                    //                 size.width *
                                                    //                     0.03,
                                                    //           ),
                                                    //           isNotificationOn
                                                    //               ? Text(
                                                    //                   "MenuNotificationOff"
                                                    //                       .tr)
                                                    //               : Text(
                                                    //                   "MenuNotificationOn"
                                                    //                       .tr)
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: primaryDarker,
                                                      ))),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Icon(
                                  Icons.more_horiz,
                                  color: primaryColor,
                                  size: size.width * 0.08,
                                ))
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['text'],
                              maxLines: null,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            post['picture'].isNotEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.pushTransparentRoute(
                                              InteractiveViewer(
                                            child: ImageMessageDetail(
                                                urlImage: post['picture']),
                                          ));
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxHeight: size.height * 0.4,
                                              maxWidth: double.infinity),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      post['picture']),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ],
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
                        LikeButtonWidget(post, currentUser!.uid),
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
}

class ImageMessageDetail extends StatelessWidget {
  const ImageMessageDetail({
    Key? key,
    required this.urlImage,
  }) : super(key: key);

  final urlImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.multi,
      child: urlImage.isNotEmpty
          ? Image.network(
              urlImage,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            )
          : Image.asset(
              //todo: default image
              "assets/images/chat_message.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            ),
    ));
  }
}

Future<dynamic> reportModalBottomSheet(BuildContext context, user, postid) {
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
                        ReportPostTypeChoice(
                          text: 'ReportNudity'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportVio'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportThreat'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportProfan'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportTerro'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportChild'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportSexual'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportAnimal'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportScam'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportAbuse'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                        ReportPostTypeChoice(
                          text: 'ReportOther'.tr,
                          userid: user['uid'],
                          postid: postid,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
}
