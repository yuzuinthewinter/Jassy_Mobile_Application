import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/noaction_appbar.dart';
import 'package:flutter_application_1/screens/main-app/like/component/like_screen_body.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NoActionAppBar(text: "ถูกใจ",),
      body: LikeScreenBody(),
    );
  }
}