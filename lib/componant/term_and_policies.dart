import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

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
        color: grey,
        fontFamily: 'Kanit',
        ),
      children: [
        TextSpan(text: 'หากคุณเข้าสู่ระบบคุณจะ'),
        TextSpan(
          text: 'ยอมรับข้อกำหนด ',
          style: TextStyle(color: secoundary),
          recognizer: TapGestureRecognizer()
            ..onTap = () => {
              print('ยอมรับข้อกำหนด')
            }),
        TextSpan(text: 'และ\n'),
        TextSpan(
          text: 'นโยบายความเป็นส่วนตัว',
          style: TextStyle(color: secoundary),
          recognizer: TapGestureRecognizer()
            ..onTap = () => {
              print('นโยบายความเป็นส่วนตัว')
            }),
        TextSpan(text: 'ของเรา'),
      ]
    ),);
  }
}