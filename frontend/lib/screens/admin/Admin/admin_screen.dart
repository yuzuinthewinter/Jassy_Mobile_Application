import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/chat_selected_appbar.dart';
import 'package:flutter_application_1/component/appbar/main_appbar.dart';
import 'package:flutter_application_1/component/appbar/noaction_appbar.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_body.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NoActionAppBar(
        text: "การจัดการระบบ",
      ),
      // body: AdminScreenBody(),
    );
  }
}
