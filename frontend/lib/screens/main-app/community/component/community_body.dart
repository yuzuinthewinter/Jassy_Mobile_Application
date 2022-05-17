import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/report_choice.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/main-app/community/admin/add_community.dart';
import 'package:flutter_application_1/screens/main-app/community/admin/manage_community.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/community_search.dart';
import 'package:flutter_application_1/screens/main-app/community/component/community_card.widget.dart';
import 'package:flutter_application_1/screens/main-app/community/component/no_news_widget.dart';
import 'package:flutter_application_1/screens/main-app/community/my_group/my_group.dart';
import 'package:flutter_application_1/screens/main-app/community/post_detail.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommunityScreenBody extends StatefulWidget {
  final user;
  final community;
  const CommunityScreenBody(this.user, this.community, {Key? key})
      : super(key: key);

  @override
  State<CommunityScreenBody> createState() => _CommunityScreenBodyState();
}

class _CommunityScreenBodyState extends State<CommunityScreenBody> {
  getAllPost() {
    List feedPost = [];
    for (var usergroupid in widget.user['groups']) {
      for (var group in widget.community) {
        if (usergroupid == group['groupid']) {
          if (group['postsID'].length > 0) {
            feedPost = feedPost + group['postsID'];
          }
        }
      }
    }
    return feedPost;
  }

  @override
  void initState() {
    super.initState();
  }

  bool isNotificationOn = false;
  bool isSavedPost = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.01),
          child: Row(children: [
            widget.user['userStatus'] == 'user'
                ? widget.user['groups'].length != 0
                    ? Text("CommuMyGroup".tr,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700))
                    : Text("CommuRecommand".tr,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700))
                : const Text(
                    "กลุ่มทั้งหมด",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
            const Spacer(),
            InkWell(
              child: Text("CommuMore".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  )),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return CommunitySearch(widget.user, widget.community);
                }));
              },
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.02),
          child: SizedBox(
            height: size.height * 0.1,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.community.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: size.width * 0.05,
                );
              },
              itemBuilder: (context, index) {
                var group = widget.community[index];
                bool isMember = false;
                for (var groupid in widget.user['groups']) {
                  if (groupid == group['groupid']) {
                    isMember = true;
                  }
                }
                return widget.user['groups'].length != 0
                    ? isMember == true
                        ? communityCard(widget.user, group, context)
                        : const SizedBox.shrink()
                    : communityCard(widget.user, group, context);
              },
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.01),
            child: widget.user['userStatus'] == 'user'
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.01),
                        child: Row(children: [
                          Text(
                            "CommuFeed".tr,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          // const Spacer(),
                          // widget.user['userStatus'] == 'user'
                          //     ? InkWell(
                          //         onTap: () {
                          //           Navigator.push(context,
                          //               CupertinoPageRoute(builder: (context) {
                          //             return MyGroup(widget.community, widget.user);
                          //           }));
                          //         },
                          //         child: Text("CommuMyGroup".tr,
                          //             style: TextStyle(
                          //               fontSize: 16,
                          //               color: primaryColor,
                          //             )))
                          //     : Container(
                          //         width: 1,
                          //       ),
                        ]),
                      ),
                      // Todo: isEmpty show NoNewsWidget
                      getAllPost().length == 0
                          ? NoNewsWidget(
                              headText: "CommuNoFeed".tr,
                              descText:
                                  "CommuStartJoin".tr,
                              size: size)
                          : SizedBox(
                              width: size.width,
                              height: size.height * 0.46,
                              child: ListView.separated(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.02),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: getAllPost().length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: size.height * 0.03,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    var postlist = getAllPost();
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            CupertinoPageRoute(
                                                builder: (context) {
                                          return PostDetail(
                                            postid: postlist[index],
                                          );
                                        }));
                                      },
                                      child:
                                          newsCard(postlist[index], context),
                                    );
                                  }),
                            ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.025),
                        width: size.width * 0.9,
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                            color: textLight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(children: [
                          MenuCard(
                            size: size,
                            icon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_circle_rounded),
                              color: primaryColor,
                            ),
                            text: 'เพิ่มกลุ่มชุมชน',
                            onTab: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return AddNewCommunity(widget.user);
                              }));
                            },
                          ),
                          MenuCard(
                            size: size,
                            icon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.people_alt),
                              color: primaryColor,
                            ),
                            text: 'การจัดการกลุ่มชุมชน',
                            onTab: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return ManageCommunity(
                                    widget.user, widget.community);
                              }));
                            },
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.025),
                        width: size.width * 0.9,
                        height: size.height * 0.075,
                        decoration: BoxDecoration(
                            color: textLight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.warning_rounded),
                                  color: secoundary,
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                const Text(
                                  "ตรวจสอบคำร้องเรียนจากชุมชน",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: textMadatory),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ))
                        ]),
                      ),
                    ],
                  )),
      ],
    );
  }

Widget newsCard(postid, context) {
  var size = MediaQuery.of(context).size;
  getDifferance(timestamp) {
    DateTime now = DateTime.now();
    DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
    Duration diff = now.difference(lastActive);

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
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Community')
                      .where('groupid', isEqualTo: post['groupid'])
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
                    var group = snapshot.data!.docs[0];
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.02),
                      decoration: BoxDecoration(
                          color: textLight,
                          border: Border(
                              bottom: BorderSide(
                                  width: size.width * 0.01,
                                  color: primaryLightest))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: !user['profilePic'].isEmpty
                                      ? NetworkImage(user['profilePic'][0])
                                      : const AssetImage(
                                              "assets/images/user3.png")
                                          as ImageProvider,
                                  radius: size.width * 0.08,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.007,
                                      ),
                                      // group name
                                      Text(
                                        StringUtils.capitalize(
                                            group['namegroup']),
                                        style: const TextStyle(
                                            fontSize: 18, color: textDark),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // post by
                                      RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: greyDark,
                                                fontSize: 14,
                                                fontFamily: 'kanit'),
                                            children: [
                                              // TextSpan(text: "${'GroupPostBy'.tr} "),
                                              TextSpan(
                                                  text: StringUtils.capitalize(
                                                      user['name']
                                                          ['firstname'])),
                                              const TextSpan(text: " • "),
                                              TextSpan(
                                                  text: getDifferance(
                                                      post['date'])),
                                            ]),
                                      ),
                                    ],
                                  ),
                                )),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.vertical(top: Radius.circular(20))),
                                      context: context, 
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context).size.height * 0.30,
                                          padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20, bottom: 15),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          // Todo: saved post
                                                          Navigator.pop(context);
                                                          setState(() {
                                                            isSavedPost = !isSavedPost;
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            isSavedPost ? SvgPicture.asset("assets/icons/unsaved_list.svg") :SvgPicture.asset("assets/icons/saved_lists.svg"),
                                                            SizedBox(width: size.width * 0.03,),
                                                            isSavedPost ? const Text("เลิกบันทึกโพสต์") : const Text("บันทึกโพสต์")
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          // Todo: Report
                                                          // reportModalBottomSheet(context);
                                                          // line 613
                                                        },
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset("assets/icons/report.svg"),
                                                            SizedBox(width: size.width * 0.03,),
                                                            const Text("รายงานโพสต์")
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          // Todo: delete post
                                                        },
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset("assets/icons/del_bin_circle.svg"),
                                                            SizedBox(width: size.width * 0.03,),
                                                            const Text("ลบโพสต์")
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                          setState(() {
                                                            isNotificationOn = !isNotificationOn;
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            isNotificationOn ? SvgPicture.asset("assets/icons/notification_off.svg") : SvgPicture.asset("assets/icons/notification_on.svg"),
                                                            SizedBox(width: size.width * 0.03,),
                                                            isNotificationOn ? Text("MenuNotificationOff".tr) : Text("MenuNotificationOn".tr)
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
                                                  onPressed: () {Navigator.pop(context);}, 
                                                  icon: const Icon(Icons.close, color: primaryDarker,)
                                                )
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    );
                                  },
                                  child: Icon(Icons.more_horiz, color: primaryColor, size: size.width * 0.08,)
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          // post text
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxHeight: double.infinity),
                              child: Column(
                                children: [
                                  Text(
                                    post['text'],
                                    maxLines: null,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: size.height * 0.02,),
                                  // Todo: post image
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(builder: (context) => FullScreenImage(context)),
                                  //     );
                                  //   },
                                    
                                  //   child: Container(
                                  //     constraints: BoxConstraints(maxHeight: size.height * 0.4, maxWidth: double.infinity),
                                  //     child: Hero(
                                  //       tag: 'post id',
                                  //       child: Image.asset("assets/images/user3.jpg", height: size.height * 0.4, width: double.infinity, fit: BoxFit.cover,)
                                  //     )
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          // like and comment icon
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
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
                  });
            });
      });

  }
}
  // Future<dynamic> reportModalBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //       context: context,
  //       builder: (context) => Container(
  //             height: MediaQuery.of(context).size.height * 0.60,
  //             padding:
  //                 const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   "MenuReport".tr,
  //                   style: const TextStyle(fontSize: 16),
  //                 ),
  //                 Align(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       "ReportChoose".tr,
  //                       style: const TextStyle(fontSize: 16),
  //                     )),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
  //                   child: Text(
  //                     "ReportDesc".tr,
  //                     style: const TextStyle(fontSize: 14, color: greyDark),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       children: [
  //                         ReportTypeChoice(
  //                           text: 'ReportNudity'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportVio'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportThreat'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportProfan'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportTerro'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportChild'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportSexual'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportAnimal'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportScam'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportAbuse'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportOther'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ));
  // }


