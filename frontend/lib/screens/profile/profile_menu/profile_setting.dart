import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/profile/profile_menu/component/profile_setting_body.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "ตั้งค่าโพรโฟล์",),
      body: ProfileSettingBody(),
    );
  }
}