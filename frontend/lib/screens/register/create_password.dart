import 'package:flutter/material.dart';
import '../../component/back_close_appbar.dart';
import 'component/create_password_body.dart';

 class CreatePassword extends StatelessWidget {
   const CreatePassword({ Key? key }) : super(key: key);
   @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     return Scaffold(
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      appBar: BackAndCloseAppBar(text: 'ตั้งค่ารหัสผ่าน'),
      body: Body(),
    );
   }
 }