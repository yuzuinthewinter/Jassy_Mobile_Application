import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/main_appbar.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_screen_body.dart';
import 'package:flutter_application_1/screens/main-app/community/community.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/jassy_main_body.dart';
import 'package:flutter_application_1/screens/main-app/like/like_screen.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class JassyMain extends StatefulWidget {
  const JassyMain(
      {Key? key})
      : super(key: key);
  @override
  State<JassyMain> createState() => _JassyMainBodyState();
}

class _JassyMainBodyState extends State<JassyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: JassyMainAppBar(
        text: "MainPage".tr,
      ),
      body: const JassyMainBody(),
    );
  }
}
