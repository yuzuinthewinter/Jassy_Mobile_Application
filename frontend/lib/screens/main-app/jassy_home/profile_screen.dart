import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/chat_selected_appbar.dart';
import 'package:flutter_application_1/screens/main-app/jassy_home/component/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ChatSelectedAppBar(
        text: "โพรไฟล์",
      ),
      body: ProfileScreenBody(),
    );
  }
}
