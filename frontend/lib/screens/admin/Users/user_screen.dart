import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/noaction_appbar.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_screen_body.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_body.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: NoActionAppBar(text: "การจัดการผู้ใช้งาน"),
      body: UserScreenBody(),
    );
  }
}
