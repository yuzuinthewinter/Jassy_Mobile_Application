import 'package:flutter/material.dart';

import '../../component/back_close_appbar.dart';
import 'component/regpage_body.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(),
      body: Body(),
      );
  }
}
