import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/body/successWithButton_body.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/detail_page.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReportPostInfoPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final report;
  // ignore: use_key_in_widget_constructors
  const ReportPostInfoPage(this.report);

  @override
  State<ReportPostInfoPage> createState() => _ReportPostInfoPage();
}

class _ReportPostInfoPage extends State<ReportPostInfoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BackAndCloseAppBar(),
      body: Column(
        children: [
          CurvedWidget(
              child: JassyGradientColor(
            gradientHeight: size.height * 0.27,
          )),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            'ReportHeader',
            // StringUtils.capitalize(widget.report['name']['firstname']) +
            //     ' ' +
            //     StringUtils.capitalize(widget.report['name']['lastname']),
            style: const TextStyle(
                fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
          ),
          // Text(
          //   'จำนวนการร้องเรียนโดยผู้ใช้ : ${widget.user['report'].length}',
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontFamily: 'kanit',
          //     fontWeight: FontWeight.w400,
          //     color:
          //         widget.user['report'].length >= 3 ? textMadatory : textDark,
          //   ),
          // ),
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
                icon: SvgPicture.asset("assets/icons/see_post.svg"),
                text: 'ดูโพสต์ต้นฉบับ',
                onTab: () {},
              ),
              ProfileMenu(
                size: size,
                icon: SvgPicture.asset("assets/icons/report.svg"),
                text: 'การรายงานอื่นๆ',
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
                    SvgPicture.asset("assets/icons/del_bin_circle.svg"),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      "ระงับการใช้งานโพสต์นี้",
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
