import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/chat_selected_appbar.dart';
import 'package:flutter_application_1/screens/main-app/demo_jassy_home/component/likes_screen_body.dart';
import 'package:get/get.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ChatSelectedAppBar(
        text: "LikePage".tr,
      ),
      body: LikeScreenBody(),
    );
  }
}
