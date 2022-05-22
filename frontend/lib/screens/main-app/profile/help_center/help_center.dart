import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/help_center/community_feedback.dart';
import 'package:flutter_application_1/screens/main-app/profile/help_center/suspended_users.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';

class HelpCenter extends StatelessWidget {
  final user;
  const HelpCenter(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
        text: "ProfileHelp".tr,
      ),
      body: Column(
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.13),
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
            width: size.width,
            height: user['isAuth'] == true
                ? size.height * 0.18
                : size.height * 0.26,
            decoration: BoxDecoration(
                color: textLight, borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              user['isAuth'] == true
                  ? const SizedBox.shrink()
                  : Expanded(
                      child: InkWell(
                      onTap: () {
                        // Todo: faceReg
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.face,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text("unverifiedUsers".tr),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: primaryColor,
                          )
                        ],
                      ),
                    )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return CommunityFeedBack();
                  }));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.rate_review,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text("CommunityFeedback".tr),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: primaryColor,
                    )
                  ],
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return SuspendedUsers();
                  }));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.report,
                      color: secoundary,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      "SuspendedUsers".tr,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: secoundary,
                    )
                  ],
                ),
              )),
            ]),
          )
        ],
      ),
    );
  }
}
