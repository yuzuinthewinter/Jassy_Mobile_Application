import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final post;
  final user;
  const PostDetailBody({Key? key, required this.post, required this.user})
      : super(key: key);

  @override
  State<PostDetailBody> createState() => _PostDetailBodyState();
}

class _PostDetailBodyState extends State<PostDetailBody> {
  TextEditingController messageController = TextEditingController();
  late FocusNode myFocusNode;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // isSavedPost = checkSavePost();
    myFocusNode = FocusNode();
    super.initState();
  }

  bool isNotificationOn = false;
  bool isSavedPost = false;

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
    CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
    CollectionReference groups =
        FirebaseFirestore.instance.collection('Community');
    await posts.doc(post['postid']).delete();
    await groups.doc(post['groupid']).update({
      'postsID': FieldValue.arrayRemove([post['postid']]),
    });
    Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        CurvedWidget(
            child: JassyGradientColor(
          gradientHeight: size.height * 0.23,
        )),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // writer avatar
                      CircleAvatar(
                        backgroundImage: !widget.user['profilePic'].isEmpty
                            ? NetworkImage(widget.user['profilePic'][0])
                            : const AssetImage("assets/images/user3.jpg")
                                as ImageProvider,
                        radius: size.width * 0.07,
                      ),
                      // writer name and post date
                      // Todo: change date format
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${StringUtils.capitalize(widget.user['name']['firstname'])} ${StringUtils.capitalize(widget.user['name']['lastname'])}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: size.height * 0.001,
                              ),
                              Text(
                                getDifferance(widget.post['date']),
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
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: widget.user['userStatus'] == 'admin'
                                        ? MediaQuery.of(context).size.height *
                                            0.16
                                        : widget.post['postby'] ==
                                                widget.user['uid']
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.30
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.24,
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
                                                  ? const SizedBox.shrink()
                                                  : isSavedPost == false
                                                      ? Expanded(
                                                          child: InkWell(
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                isSavedPost =
                                                                    true;
                                                              });
                                                              await savePost(
                                                                  widget.post);
                                                            },
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    "assets/icons/saved_lists.svg"),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
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
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                isSavedPost =
                                                                    false;
                                                              });
                                                              await unsavePost(
                                                                  widget.post);
                                                            },
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    "assets/icons/unsaved_list.svg"),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
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
                                                  : widget.post['postby'] !=
                                                          widget.user['uid']
                                                      ? Expanded(
                                                          child: InkWell(
                                                            onTap: () {
                                                              // Todo: Report
                                                              reportModalBottomSheet(
                                                                  context,
                                                                  widget.user,
                                                                  widget.post[
                                                                      'postid']);
                                                              // line 613
                                                            },
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    "assets/icons/report.svg"),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.03,
                                                                ),
                                                                Text(
                                                                    "GroupPostReport"
                                                                        .tr)
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                              widget.user['userStatus'] ==
                                                      'admin'
                                                  ? Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return WarningPopUpWithButton(
                                                                  text:
                                                                      'GroupDeleteWarning'
                                                                          .tr,
                                                                  okPress: () {
                                                                    deletePost(
                                                                        widget
                                                                            .post);
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
                                                                  size.width *
                                                                      0.03,
                                                            ),
                                                            Text(
                                                                "GroupPostDelete"
                                                                    .tr)
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : widget.post['postby'] ==
                                                          widget.user['uid']
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
                                                                            widget.post);
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
                                                                      size.width *
                                                                          0.03,
                                                                ),
                                                                Text(
                                                                    "GroupPostDelete"
                                                                        .tr)
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                              widget.user['userStatus'] ==
                                                      'admin'
                                                  ? const SizedBox.shrink()
                                                  : Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {
                                                            isNotificationOn =
                                                                !isNotificationOn;
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            isNotificationOn
                                                                ? SvgPicture.asset(
                                                                    "assets/icons/notification_off.svg")
                                                                : SvgPicture.asset(
                                                                    "assets/icons/notification_on.svg"),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.03,
                                                            ),
                                                            isNotificationOn
                                                                ? Text(
                                                                    "MenuNotificationOff"
                                                                        .tr)
                                                                : Text(
                                                                    "MenuNotificationOn"
                                                                        .tr)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
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
                        children: [
                          Text(
                            widget.post['text'],
                            maxLines: null,
                            style: TextStyle(fontSize: 16),
                          ),
                          widget.post['picture'].isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    width: size.width * 0.5,
                                    height: size.height * 0.3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              widget.post['picture']),
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
                      //todo: trigger new event
                      LikeButtonWidget(widget.post, currentUser!.uid),
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
                // SingleChildScrollView(child: JassyCommentTree()),
              ],
            ),
          ),
        ),
        CommentInput(
          size: size,
          child: Input(myFocusNode: myFocusNode),
        ),
      ],
    );
  }
}

// input text with nodefocus
class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.myFocusNode,
  }) : super(key: key);

  final FocusNode myFocusNode;

  //TODO: implement add comment
  //String type = 'text';
  // addComment(postid, comment) async {
  //   var currentUser = FirebaseAuth.instance.currentUser;
  //   CollectionReference comments =
  //       FirebaseFirestore.instance.collection('Comments');
  //   CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
  //   DocumentReference docRef = await comments.add({
  //     'postid': postid,
  //     'comment': comment,
  //     'type': type,
  //     'commentBy': currentUser!.uid,
  //     'date': DateTime.now(),
  //     'likes': [],
  //   });
  //   await posts.doc(postid).update({
  //     'comments': FieldValue.arrayUnion([docRef.id])
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: messageController,
      focusNode: myFocusNode,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: "GroupPostCommentHintText".tr,
        suffixIcon: InkWell(
            // TODO : add emoji picker (ammie)
            onTap: () {
              print("emoji");
            },
            child: const Icon(
              Icons.sentiment_satisfied_alt,
              color: primaryColor,
            )),
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
