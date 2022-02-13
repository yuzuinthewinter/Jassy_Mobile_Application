import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class AccountExistsLogin extends StatelessWidget {
  const AccountExistsLogin({
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
        TextSpan(text: 'มีบัญชีผู้ใช้อยู่แล้ว ? '),
        TextSpan(
          text: 'เข้าสู่ระบบ ',
          style: TextStyle(color: primaryColor,),
          recognizer: TapGestureRecognizer()
            ..onTap = () => {
              print('เข้าสู่ระบบ')
            }),
      ]
    ),);
  }
}