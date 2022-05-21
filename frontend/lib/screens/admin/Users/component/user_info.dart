import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/body/successWithButton_body.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/report/listReportUser.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/detail_page.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final user;
  // ignore: use_key_in_widget_constructors
  const UserInfoPage(this.user);

  @override
  State<UserInfoPage> createState() => _UserInfoPage();
}

class _UserInfoPage extends State<UserInfoPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  warningChangeStatusUser() async {
    await users.doc(widget.user['uid']).update({
      'userStatus': 'blocked',
    });
    Navigator.of(context).pop();
  }

  warningCancelBlocked() async {
    await users.doc(widget.user['uid']).update({
      'userStatus': 'user',
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BackAndCloseAppBar(),
      body: Column(
        children: [
          ProfilePictureWidget(size: size, user: widget.user),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            StringUtils.capitalize(widget.user['name']['firstname']) +
                ' ' +
                StringUtils.capitalize(widget.user['name']['lastname']),
            style: const TextStyle(
                fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
          ),
          widget.user['userStatus'] == 'admin'
              ? const Text(
                  'Administrator',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'kanit',
                      fontWeight: FontWeight.w400),
                )
              : Text(
                  'จำนวนการร้องเรียนโดยผู้ใช้ : ${widget.user['report'].length}',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'kanit',
                    fontWeight: FontWeight.w400,
                    color: widget.user['report'].length >= 3
                        ? textMadatory
                        : textDark,
                  ),
                ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
            width: size.width,
            height: size.height * 0.15,
            decoration: BoxDecoration(
                color: textLight, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                widget.user['userStatus'] == 'admin'
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/facereg_icon.svg"),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              'การยืนยันตัวตนของผู้ใช้',
                              style: TextStyle(fontSize: 15),
                            ),
                            // const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.verified_rounded),
                              color: widget.user['isAuth'] == true
                                  ? widget.user['report'].length < 5
                                      ? primaryColor
                                      : greyDark
                                  : textLight,
                            ),
                          ],
                        ),
                      )),
                ProfileMenu(
                  size: size,
                  icon: SvgPicture.asset("assets/icons/profile_icon.svg"),
                  text: 'โพรไฟล์',
                  onTab: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Interval(0, 0.5),
                      );
                      return FadeTransition(
                        opacity: curvedAnimation,
                        child: DetailPage(
                            user: widget.user,
                            isMainPage: true,
                            animation: animation),
                      );
                    }));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
            width: size.width,
            height: widget.user['userStatus'] == 'blocked'
                ? size.height * 0.15
                : widget.user['report'].length < 5
                    ? size.height * 0.075
                    : size.height * 0.15,
            decoration: BoxDecoration(
                color: textLight, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Expanded(
                    child: InkWell(
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/report_red.svg"),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        "ตรวจสอบคำร้องเรียนของผู้ใช้รายนี้",
                        style: TextStyle(color: textMadatory),
                      ),
                      Spacer(),
                      // Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return ListReportUserScreen(widget.user);
                    }));
                  },
                )),
                widget.user['userStatus'] == 'blocked'
                    ? Expanded(
                        child: InkWell(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/report_red.svg"),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                "ยกเลิกระงับการใช้งานผู้ใช้",
                                style: TextStyle(color: textMadatory),
                              ),
                              Spacer(),
                              // Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                            ],
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return WarningPopUpWithButton(
                                    text: 'WarningAdminUnblocked'.tr,
                                    okPress: () {
                                      warningCancelBlocked();
                                    },
                                  );
                                });
                          },
                        ),
                      )
                    : widget.user['report'].length < 5
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: InkWell(
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/report_red.svg"),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Text(
                                  "ระงับการใช้งานผู้ใช้",
                                  style: TextStyle(color: textMadatory),
                                ),
                                Spacer(),
                                // Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return WarningPopUpWithButton(
                                      text: 'WarningAdminBlocked'.tr,
                                      okPress: () {
                                        warningChangeStatusUser();
                                      },
                                    );
                                  });
                            },
                          )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
