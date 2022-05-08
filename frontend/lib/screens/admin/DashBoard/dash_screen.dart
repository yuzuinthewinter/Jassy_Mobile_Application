import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/noaction_appbar.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NoActionAppBar(text: "ข้อมูลการใช้งาน"),
      // body: DashboardScreenBody(),
    );
  }
}