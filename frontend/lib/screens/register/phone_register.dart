import 'package:flutter/material.dart';

import '../../component/back_close_appbar.dart';
import 'component/phonereg_body.dart';

 class PhoneRegister extends StatelessWidget {
   const PhoneRegister({ Key? key }) : super(key: key);
   @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: BackAndCloseAppBar(text: 'ลงทะเบียนด้วยเบอร์โทรศัพท์'),
      body: Body(),
      );
   }
 }