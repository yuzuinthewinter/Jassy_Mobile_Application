import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/component/text/report_choice.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/component/comment_input.dart';
import 'package:flutter_application_1/screens/main-app/community/component/comment_tree.dart';
import 'package:flutter_application_1/screens/main-app/community/component/report_post.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostDetailBody extends StatefulWidget {
  final postid;
  // final user;
  const PostDetailBody({Key? key, required this.postid}) : super(key: key);

  @override
  State<PostDetailBody> createState() => _PostDetailBodyState();
}

class _PostDetailBodyState extends State<PostDetailBody> {
  TextEditingController messageController = TextEditingController();
  late FocusNode myFocusNode;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // isSavedPost = checkSavePost();
    myFocusNode = FocusNode();
    super.initState();
  }

  // checkSavePost() async {
  //   CollectionReference savePost =
  //       FirebaseFirestore.instance.collection('SavePosts');
  //   if (widget.post['postid']) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  String type = 'text';
  addComment(postid, comment) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference comments =
        FirebaseFirestore.instance.collection('Comments');
    CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
    DocumentReference docRef = await comments.add({
      'postid': postid,
      'comment': comment,
      'type': type,
      'commentBy': currentUser!.uid,
      'date': DateTime.now(),
      'likes': [],
    });
    await comments.doc(docRef.id).update({
      'commentid': docRef.id,
    });
    await posts.doc(postid).update({
      'comments': FieldValue.arrayUnion([docRef.id])
    });
    messageController.clear();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Posts")
            .where('postid', isEqualTo: widget.postid)
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text(''));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text(''));
          }
          var post = snapshot.data!.docs[0];
          return Column(
            children: [
              CurvedWidget(
                  child: JassyGradientColor(
                gradientHeight: size.height * 0.23,
              )),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('uid', isEqualTo: post['postby'])
                        .snapshots(includeMetadataChanges: true),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text(''));
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text(''));
                      }
                      var queryUser = snapshot.data!.docs[0];
                      return FullPostDetail(
                        post: post,
                        user: queryUser,
                        myFocusNode: myFocusNode,
                      );
                    },
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .where('uid', isEqualTo: currentUser!.uid)
                      .snapshots(includeMetadataChanges: true),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Text(''));
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text(''));
                    }
                    var user = snapshot.data!.docs[0];
                    bool isMember = false;
                    for (var groupid in user['groups']) {
                      if (groupid == post['groupid']) {
                        isMember = true;
                      }
                    }
                    return user['userStatus'] == 'admin'
                        ? CommentInput(
                            size: size,
                            onTab: () {
                              addComment(post['postid'], messageController.text);
                            },
                            child: inputConsole(),
                          )
                        : isMember
                            ? CommentInput(
                                size: size,
                                onTab: () {
                                  addComment(
                                      post['postid'], messageController.text);
                                },
                                child: inputConsole(),
                              )
                            : const SizedBox.shrink();
                  }),
            ],
          );
        });
  }

  Widget inputConsole() {
    return TextField(
      controller: messageController,
      focusNode: myFocusNode,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: "GroupPostCommentHintText".tr,
        filled: true,
        fillColor: textLight,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: primaryLighter, width: 0.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: primaryLighter),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: primaryLighter),
        ),
      ),
    );
  }
}

class FullPostDetail extends StatelessWidget {
  FullPostDetail({
    Key? key,
    required this.post,
    required this.user,
    required this.myFocusNode,
  }) : super(key: key);
  final post;
  final user;
  final myFocusNode;

  var currentUser = FirebaseAuth.instance.currentUser;

  getDifferance(timestamp) {
    DateTime now = DateTime.now();
    DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
    Duration diff = now.difference(lastActive);

    String formattedHours = DateFormat('KK:mm a').format(lastActive);
    String formattedDay = DateFormat('EEE, d/M').format(lastActive);
    String formattedDaywithyear = DateFormat('EEE, d/M/y').format(lastActive);

    var timeMin = diff.inMinutes;
    var timeHour = diff.inHours;
    var timeDay = diff.inDays;
    if (timeDay < 1) {
      return '${'GroupPostToday'.tr}, $formattedHours';
    } else if (timeDay < 2) {
      return '${'GroupPostYesterday'.tr}, $formattedHours';
    } else if (timeDay < 365) {
      return formattedDay;
    } else {
      return formattedDaywithyear;
    }
  }

  bool isNotificationOn = false;
  bool isSavedPost = false;

  CollectionReference savePosts =
      FirebaseFirestore.instance.collection('SavePosts');
  savePost(post, current) async {
    var queryPost = savePosts.where('savedBy', isEqualTo: currentUser!.uid);
    QuerySnapshot querySnapshot = await queryPost.get();
    if (querySnapshot.docs.isNotEmpty) {
      await savePosts.doc(currentUser!.uid).update({
        'savedBy': currentUser!.uid,
        'saved': FieldValue.arrayUnion([post['postid']])
      });
    } else {
      await savePosts.doc(currentUser!.uid).set({
        'savedBy': currentUser!.uid,
        'saved': FieldValue.arrayUnion([post['postid']])
      });
    }
  }

  unsavePost(post) async {
    await savePosts.doc(currentUser!.uid).update({
      'saved': FieldValue.arrayRemove([post['postid']]),
    });
  }

  deletePost(post, context) async {
    CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
    CollectionReference groups =
        FirebaseFirestore.instance.collection('Community');
    await posts.doc(post['postid']).delete();
    await groups.doc(post['groupid']).update({
      'postsID': FieldValue.arrayRemove([post['postid']]),
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderPost(context),
        SizedBox(
          height: size.height * 0.02,
        ),
        // post text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['text'],
                    maxLines: null,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  post['picture'].isNotEmpty
                      ? InkWell(
                          onTap: () {
                            context.pushTransparentRoute(InteractiveViewer(
                              child:
                                  ImageMessageDetail(urlImage: post['picture']),
                            ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: size.width,
                              height: size.height * 0.4,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(post['picture']),
                                    fit: BoxFit.cover),
                              ),
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
              //todo: trigger new event
              LikeButtonWidget(post, currentUser!.uid),
              SizedBox(width: size.width * 0.05),
              InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(myFocusNode);
                  },
                  child: SvgPicture.asset(
                    "assets/icons/comment_icon.svg",
                    width: size.width * 0.07,
                  ))
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        //TODO: show comment here
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(
              top: 0,
            ),
            itemCount: post['comments'].length,
            itemBuilder: (context, index) {
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Comments')
                      .where('commentid', isEqualTo: post['comments'][index])
                      .snapshots(includeMetadataChanges: true),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Text(''));
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text(''));
                    }
                    var comment = snapshot.data!.docs[0];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.01),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .where('uid', isEqualTo: comment['commentBy'])
                              .snapshots(includeMetadataChanges: true),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(child: Text(''));
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(child: Text(''));
                            }
                            var user = snapshot.data!.docs[0];
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: user['profilePic']
                                              .isNotEmpty
                                          ? NetworkImage(user['profilePic'][0])
                                          : const AssetImage(
                                                  "assets/images/user3.jpg")
                                              as ImageProvider,
                                      radius: size.width * 0.05,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    Container(
                                        constraints: BoxConstraints(
                                            maxWidth: size.width * 0.7),
                                        padding: EdgeInsets.only(
                                            right: size.width * 0.03,
                                            left: size.width * 0.03,
                                            bottom: size.width * 0.03,
                                            top: size.width * 0.015),
                                        decoration: BoxDecoration(
                                            color: textLight,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: textDark,
                                                  fontFamily: 'Kanit',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '${StringUtils.capitalize(user['name']['firstname'])} ${StringUtils.capitalize(user['name']['lastname'])}\n'),
                                                TextSpan(
                                                    text: comment['comment'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16)),
                                              ]),
                                        ))
                                  ],
                                ),
                              ],
                            );
                          }),
                    );
                  });
            }),
      ],
    );
  }

  Widget HeaderPost(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // writer avatar
          CircleAvatar(
            backgroundImage: user['profilePic'].isNotEmpty
                ? NetworkImage(user['profilePic'][0])
                : const AssetImage("assets/images/user3.jpg") as ImageProvider,
            radius: size.width * 0.07,
          ),
          // writer name and post date
          // Todo: change date format
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${StringUtils.capitalize(user['name']['firstname'])} ${StringUtils.capitalize(user['name']['lastname'])}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: size.height * 0.001,
                  ),
                  Text(
                    getDifferance(post['date']),
                    style: const TextStyle(color: greyDark),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .where('uid', isEqualTo: currentUser!.uid)
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
                            var current = snapshot.data!.docs[0];
                            return Container(
                              height: current['userStatus'] == 'admin'
                                  ? MediaQuery.of(context).size.height * 0.12
                                  : post['postby'] == current['uid']
                                      ? MediaQuery.of(context).size.height * 0.2
                                      : MediaQuery.of(context).size.height *
                                          0.2,
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 20.0, right: 20, bottom: 15),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    child: Column(
                                      children: [
                                        current['userStatus'] == 'admin'
                                            ? const SizedBox.shrink()
                                            : isSavedPost == false
                                                ? Expanded(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                        isSavedPost = true;
                                                        await savePost(
                                                            post, current);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
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
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                        isSavedPost = false;
                                                        await unsavePost(post);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
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
                                        current['userStatus'] == 'admin'
                                            ? const SizedBox
                                                .shrink() //TODO: report list
                                            : post['postby'] != current['uid']
                                                ? Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Todo: Report
                                                        reportModalBottomSheet(
                                                            context,
                                                            user,
                                                            post['postid']);
                                                        // line 613
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
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
                                                : const SizedBox.shrink(),
                                        current['userStatus'] == 'admin'
                                            ? Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return WarningPopUpWithButton(
                                                            text:
                                                                'GroupDeleteWarning'
                                                                    .tr,
                                                            okPress: () {
                                                              deletePost(post,
                                                                  context);
                                                            },
                                                          );
                                                        });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          "assets/icons/del_bin_circle.svg"),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.03,
                                                      ),
                                                      Text("GroupPostDelete".tr)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : post['postby'] == current['uid']
                                                ? Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return WarningPopUpWithButton(
                                                                text:
                                                                    'GroupDeleteWarning'
                                                                        .tr,
                                                                okPress: () {
                                                                  deletePost(
                                                                      post,
                                                                      context);
                                                                },
                                                              );
                                                            });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
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
                                                : const SizedBox.shrink(),
                                        current['userStatus'] == 'admin'
                                            ? const SizedBox.shrink()
                                            : const SizedBox.shrink()
                                        // : Expanded(
                                        //     child: InkWell(
                                        //       onTap: () {
                                        //         isNotificationOn =
                                        //             !isNotificationOn;
                                        //         Navigator.pop(context);
                                        //       },
                                        //       child: Row(
                                        //         children: [
                                        //           isNotificationOn
                                        //               ? SvgPicture.asset(
                                        //                   "assets/icons/notification_off.svg")
                                        //               : SvgPicture.asset(
                                        //                   "assets/icons/notification_on.svg"),
                                        //           SizedBox(
                                        //             width:
                                        //                 size.width * 0.03,
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
                    });
              },
              child: Icon(
                Icons.more_horiz,
                color: primaryColor,
                size: size.width * 0.08,
              ))
        ],
      ),
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
