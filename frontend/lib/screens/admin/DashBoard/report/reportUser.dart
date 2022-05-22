import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/noaction_appbar.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/dash_screen_body.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/report/ReportUserScreen.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_body.dart';

class ReportUserScreen extends StatelessWidget {
  const ReportUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "คำร้องเรียนผู้ใช้งาน"),
      body: ReportUserScreenBody(),
    );
  }
}
