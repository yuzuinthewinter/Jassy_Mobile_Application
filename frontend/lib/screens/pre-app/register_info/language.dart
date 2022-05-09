import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/pre-app/register_info/component/language_body.dart';
import 'package:get/get.dart';

class RegisterLanguage extends StatelessWidget {
  final NameType name;
  final InfoType uinfo;

  // ignore: use_key_in_widget_constructors
  const RegisterLanguage(this.name, this.uinfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
        text: "LandingRegister".tr,
      ),
      body: Body(name, uinfo),
    );
  }
}
