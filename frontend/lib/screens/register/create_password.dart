import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/register/component/create_password_body.dart';

 class CreatePassword extends StatelessWidget {
   const CreatePassword({ Key? key }) : super(key: key);
   @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     return const Scaffold(
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      appBar: BackAndCloseAppBar(text: 'ตั้งค่ารหัสผ่าน'),
      body: Body(),
    );
   }
 }