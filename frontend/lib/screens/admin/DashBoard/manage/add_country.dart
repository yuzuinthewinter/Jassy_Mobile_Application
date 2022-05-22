// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/theme/index.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
class AddCountryScreenBody extends StatefulWidget {
  const AddCountryScreenBody({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<AddCountryScreenBody> createState() => _AddCountryScreenBody();
}

class _AddCountryScreenBody extends State<AddCountryScreenBody> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "การจัดการประเทศที่รองรับ"),
      body: Column(children: [
        CurvedWidget(child: JassyGradientColor()),
        SizedBox(
          height: size.height * 0.04,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
          width: size.width,
          height: size.height * 0.1,
          decoration: BoxDecoration(
              color: textLight, borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            MenuCard(
              size: size,
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_location_rounded),
                color: primaryColor,
              ),
              text: 'เพิ่มประเทศ',
              onTab: () {
                // Navigator.push(context, CupertinoPageRoute(builder: (context) {
                //   return AddCountryScreenBody();
                // }));
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
