import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/pre-app/register_info/component/profile_body.dart';
import 'package:get/get.dart';

class RegisterProfile extends StatelessWidget {
  const RegisterProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "LandingRegister".tr,),
      body: Body(),
    );
  }
}