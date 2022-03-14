import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/register_info/component/language_body.dart';

class RegisterLanguage extends StatelessWidget {
  const RegisterLanguage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "ลงทะเบียนผู้ใช้ใหม่",),
      body: Body(),
    );
  }
}