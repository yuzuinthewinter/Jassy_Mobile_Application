import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/pre-app/login/component/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: BackAndCloseAppBar(text: 'เข้าสู่ระบบ'),
      body: Body(),
      );
  }
}
