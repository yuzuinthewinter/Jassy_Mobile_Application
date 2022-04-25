import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/popup_page/body/successWithButton_body.dart';

class SuccessPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String SuccessWord;
  // ignore: use_key_in_widget_constructors
  const SuccessPage(this.SuccessWord);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const BackAndCloseAppBar(),
      body: Body(SuccessWord),
    );
  }
}
