import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style1.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';

class PhaseOneSuccess extends StatefulWidget {
  const PhaseOneSuccess({Key? key}) : super(key: key);

  @override
  State<PhaseOneSuccess> createState() => _PhaseOneSuccess();
}

class _PhaseOneSuccess extends State<PhaseOneSuccess> {
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
                'PhaseOneSuccessHeader'.tr,
                style: const TextStyle(fontSize: 20, color: textDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.012,
              ),
              Text(
                'PhaseOneSuccessDetail'.tr,
                style: const TextStyle(fontSize: 16, color: greyDark),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButtonComponent(
                  text: "PhaseOneGoToApp".tr,
                  minimumSize: Size(size.width * 0.35, size.height * 0.05),
                  press: () {
                    Navigator.of(context).pushNamed(Routes.JassyHome,
                        arguments: [4, false, true]);
                  }),
              Center(
                child: DisableToggleButton(
                  color: primaryColor,
                  text: "PhaseOneGoToPhaseTwo".tr,
                  minimumSize: Size(size.width * 0.55, size.height * 0.05),
                  press: () {
                    Navigator.of(context).pushNamed(Routes.PictureUpload);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
