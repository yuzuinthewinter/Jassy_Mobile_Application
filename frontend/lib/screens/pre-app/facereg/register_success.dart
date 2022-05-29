import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({Key? key}) : super(key: key);

  @override
  State<RegisterSuccess> createState() => _RegisterSuccess();
}

class _RegisterSuccess extends State<RegisterSuccess> {
  var users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
        text: "LandingRegister".tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          SizedBox(
            height: size.height * 0.01,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/phase_one_success.svg',
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'PhaseTwoSuccessHeader'.tr,
                style: const TextStyle(fontSize: 20, color: textDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.012,
              ),
              Text(
                'PhaseTwoSuccessDetail'.tr,
                style: const TextStyle(fontSize: 16, color: greyDark),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: DisableToggleButton(
              color: primaryColor,
              text: "PhaseOneGoToApp".tr,
              minimumSize: Size(size.width * 0.8, size.height * 0.05),
              press: () {
                Navigator.of(context).pushNamed(Routes.JassyHome, arguments: [4, true, false]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
