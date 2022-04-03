import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/translations.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class TermAndPolicies extends StatelessWidget {
  const TermAndPolicies({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: TextStyle(
            color: greyDark,
            fontFamily: 'Kanit',
          ),
          children: [
            TextSpan(text: 'LandingPreTermOfService'.tr),
            TextSpan(
                text: Get.locale.toString() == 'th_TH'
                    ? 'LandingTermOfService'.tr
                    : '\n${'LandingTermOfService'.tr}',
                style: TextStyle(color: secoundary),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        // print('ยอมรับข้อกำหนด')
                      }),
            TextSpan(
                text: Get.locale.toString() == 'th_TH'
                    ? 'ConAnd'.tr + '\n'
                    : ' ${'ConAnd'.tr} '),
            TextSpan(
                text: 'LandingPrivacy'.tr,
                style: TextStyle(color: secoundary),
                recognizer: TapGestureRecognizer()..onTap = () => {}),
          ]),
    );
  }
}
