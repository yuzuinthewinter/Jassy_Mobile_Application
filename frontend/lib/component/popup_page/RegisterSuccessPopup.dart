import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/popup_page/body/RegisterSuccessPopup_body.dart';

class RegisterSuccessPopup extends StatelessWidget {
  final String SuccessWord;

  RegisterSuccessPopup(this.SuccessWord);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: BackAndCloseAppBar(),
      body: Body(this.SuccessWord),
    );
  }
}
