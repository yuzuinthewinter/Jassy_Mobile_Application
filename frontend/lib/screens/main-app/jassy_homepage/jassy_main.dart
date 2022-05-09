import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/main_appbar.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/jassy_main_body.dart';
import 'package:get/get.dart';

class JassyMain extends StatelessWidget {
  const JassyMain({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: JassyMainAppBar(text: "MainPage".tr,),
      body: JassyMainBody(),
    );
  }
}