import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/main-app/community/admin/add_community.dart';
import 'package:flutter_application_1/screens/main-app/community/admin/manage_community.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/community_search.dart';
import 'package:flutter_application_1/screens/main-app/community/component/community_card.widget.dart';
import 'package:flutter_application_1/screens/main-app/community/component/news_card_widget.dart';
import 'package:flutter_application_1/screens/main-app/community/my_group/my_group.dart';
import 'package:flutter_application_1/screens/main-app/community/post_detail.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommunityScreenBody extends StatefulWidget {
  final user;
  final community;
  const CommunityScreenBody(this.user, this.community, {Key? key})
      : super(key: key);

  @override
  State<CommunityScreenBody> createState() => _CommunityScreenBodyState();
}

class _CommunityScreenBodyState extends State<CommunityScreenBody> {
  @override
  void initState() {
    super.initState();
  }

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
                ? Text(
                    "CommuRecommand".tr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )
                : const Text(
                    "กลุ่มทั้งหมด",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
            const Spacer(),
            InkWell(
              child: Text("CommuMore".tr,
                  style: TextStyle(
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
                return communityCard(widget.user, widget.community[index], context);
              },
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: size.height * 0.01),
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        widget.user['userStatus'] == 'user'
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return MyGroup(widget.community, widget.user);
                                  }));
                                },
                                child: Text("CommuMyGroup".tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: primaryColor,
                                    )))
                            : Container(
                                width: 1,
                              ),
                      ]),
                    ),
                    // Todo: isEmpty show NoNewsWidget
                    // NoNewsWidget(
                    //   headText: "ยังไม่มีข่าวสารสำหรับคุณ",
                    //   descText: "เริ่มเข้ากลุ่มเพื่อรับข่าวสารและแลกเปลี่ยนกันเถอะ !",
                    //   size: size
                    // )
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.46,
                      child: ListView.separated(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: newsLists.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: size.height * 0.03,
                            );
                          },
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                  Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                  return PostDetail(post: newsLists[index],);
                                }));
                              },
                              child: newsCard(newsLists[index], context)
                            );
                          }),
                    )
                  ],
                ) :Column(
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * 0.025),
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
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * 0.025),
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
                            Text(
                              "ตรวจสอบคำร้องเรียนจากชุมชน",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: textMadatory),
                            ),
                            Spacer(),
                          ],
                        ),
                      ))
                    ]),
                  ),
                ],
              )
              ),
      ],
    );
  }
}
