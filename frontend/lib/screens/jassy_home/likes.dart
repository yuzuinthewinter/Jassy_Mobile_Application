import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/chat_selected_appbar.dart';
import 'package:flutter_application_1/screens/jassy_home/component/likes_screen_body.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ChatSelectedAppBar(
        text: "ถูกใจ",
      ),
      body: LikeScreenBody(),
    );
  }
}
