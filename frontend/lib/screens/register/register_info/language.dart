import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/register/register_info/component/language_body.dart';

class RegisterLanguage extends StatelessWidget {
  final NameType name;
  final InfoType uinfo;

  // ignore: use_key_in_widget_constructors
  const RegisterLanguage(this.name, this.uinfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BackAndCloseAppBar(
        text: "ลงทะเบียนผู้ใช้ใหม่",
      ),
      body: Body(name, uinfo),
    );
  }
}
