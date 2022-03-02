import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/forgot_password/component/change_password_success_body.dart';

class ChangePasswordSuccess extends StatelessWidget {
  const ChangePasswordSuccess({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: BackAndCloseAppBar(),
      body: Body(),
      );
  }
}