import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/main-app/community/my_group/component/my_group_body.dart';

class MyGroup extends StatelessWidget {
  const MyGroup({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "กลุ่มของฉัน"),
      body: MyGroupBody(),
    );
  }
}