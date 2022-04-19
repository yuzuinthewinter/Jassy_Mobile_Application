import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/register/component/phonereg_body.dart';
import 'package:get/get.dart';

 class PhoneRegister extends StatelessWidget {
   const PhoneRegister({ Key? key }) : super(key: key);
   @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: BackAndCloseAppBar(text: 'PhoneRegisterPage'.tr),
      body: const Body(),
      );
   }
 }