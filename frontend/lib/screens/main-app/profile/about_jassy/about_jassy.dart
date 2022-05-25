import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';

class AboutJassy extends StatelessWidget {
  const AboutJassy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "ProfileAboutJassy".tr,),
      body: Column(
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          Text(
            "ProfileAboutJassy".tr,
            style: TextStyle(
              fontSize: 18
            ),
          ),
          Divider(
            endIndent: size.width * 0.07,
            indent: size.width * 0.07,
            thickness: 3,
            color: grey,
            height: size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Text(
              "AboutJassyApp".tr,
              style: TextStyle(
                fontSize: 14
              ),
            ),
          )
        ]
      ),
    );
  }
}