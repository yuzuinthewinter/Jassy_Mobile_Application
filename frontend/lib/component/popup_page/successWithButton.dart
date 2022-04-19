import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/popup_page/body/successWithButton_body.dart';

class SuccessPage extends StatelessWidget {
  final String SuccessWord;
  SuccessPage(this.SuccessWord);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: BackAndCloseAppBar(),
      body: Body(this.SuccessWord),
    );
  }
}
