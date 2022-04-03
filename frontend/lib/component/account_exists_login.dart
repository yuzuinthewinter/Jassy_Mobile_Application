import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/constants/translations.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class AccountExistsLogin extends StatelessWidget {
  const AccountExistsLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
        style: TextStyle(
          color: greyDark,
          fontFamily: 'Kanit',
          ),
        children: [
          TextSpan(text: 'LandingHaveAccount'.tr),
          TextSpan(
            text: ' ${'LandingLogin'.tr}',
            style: TextStyle(color: primaryColor,),
            recognizer: TapGestureRecognizer()
              ..onTap = () => {
                Navigator.pushNamed(
                  context, 
                  Routes.LoginPage
                )
              }),
        ]
      ),),
    );
  }
}