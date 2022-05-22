import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/pre-app/landing/componant/privacy_policy.dart';
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
          style: const TextStyle(
            color: greyDark,
            fontFamily: 'Kanit',
          ),
          children: [
            TextSpan(text: 'LandingPreTermOfService'.tr + '\n'),
            TextSpan(
                text: 'LandingPrivacy'.tr,
                style: const TextStyle(color: secoundary),
                recognizer: TapGestureRecognizer()..onTap = () => { 
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return PrivacyPolicy(okPress: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Routes.RegisterPage);
                      });
                    }) 
                }),
          ]),
    );
  }
}
