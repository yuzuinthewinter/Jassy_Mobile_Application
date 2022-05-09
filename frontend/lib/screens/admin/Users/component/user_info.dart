import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/body/successWithButton_body.dart';
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
            widget.user['name']['firstname'].toString() +
                ' ' +
                widget.user['name']['lastname'].toString(),
            style: const TextStyle(
                fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
          ),
          Text(
            'จำนวนการร้องเรียนโดยผู้ใช้ : ${widget.user['reportCount']}',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'kanit',
              fontWeight: FontWeight.w400,
              color: widget.user['reportCount'] >= 3 ? textMadatory : textDark,
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
            child: Column(children: [
              ProfileMenu(
                size: size,
                icon: SvgPicture.asset("assets/icons/profile_icon.svg"),
                text: 'โพรไฟล์',
                onTab: () {
                  // Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  //   return const AppSetting();
                  // }));
                },
              ),
              ProfileMenu(
                size: size,
                icon: SvgPicture.asset("assets/icons/facereg_icon.svg"),
                text: 'การยืนยันตัวตนของผู้ใช้',
                onTab: () {
                  // Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  //   return const AppSetting();
                  // }));
                },
              ),
            ]),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
            width: size.width,
            height: size.height * 0.075,
            decoration: BoxDecoration(
                color: textLight, borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Expanded(
                  child: InkWell(
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/report_red.svg"),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      "ตรวจสอบคำร้องเรียนจากผู้ใช้รายอื่น",
                      style: TextStyle(color: textMadatory),
                    ),
                    Spacer(),
                    // Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                  ],
                ),
                onTap: () {},
              )),
            ]),
          ),
        ],
      ),
    );
  }
}
