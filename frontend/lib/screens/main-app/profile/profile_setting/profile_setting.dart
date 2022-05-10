import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile_setting/component/profile_setting_body.dart';
import 'package:get/get.dart';

class ProfileSetting extends StatelessWidget {
  final user;
  // ignore: use_key_in_widget_constructors
  const ProfileSetting({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
        text: "ProfileSetting".tr,
      ),
      body: ProfileSettingBody(user),
    );
  }
}
