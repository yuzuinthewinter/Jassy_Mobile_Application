import 'package:flutter/material.dart';

import '../../component/back_close_appbar.dart';
import 'component/otp.body.dart';

 class EnterOTP extends StatelessWidget {
   const EnterOTP({ Key? key }) : super(key: key);
   @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: BackAndCloseAppBar(text: 'ลงทะเบียนด้วยเบอร์โทรศัพท์'),
      body: const Body(phoneNumber: '',)
    );
   }
 }