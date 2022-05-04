import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/main-app/profile/app_setting/component/app_setting_body.dart';

class AppSetting extends StatelessWidget {
  const AppSetting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "การตั้งค่า",),
      body: AppSettingBody(),
    );
  }
}