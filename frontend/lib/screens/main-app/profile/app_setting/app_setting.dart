import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/main-app/profile/app_setting/component/app_setting_body.dart';
import 'package:get/get.dart';

class AppSetting extends StatelessWidget {
  final user;
  const AppSetting(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
        text: 'AppSetting'.tr,
      ),
      body: AppSettingBody(user),
    );
  }
}
