import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/register/component/otp.body.dart';

 class EnterOTP extends StatelessWidget {
   final String phoneNumber;
   EnterOTP(this.phoneNumber);

   @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: BackAndCloseAppBar(text: 'ลงทะเบียนด้วยเบอร์โทรศัพท์'),
      body: Body(this.phoneNumber),
    );
   }
 }