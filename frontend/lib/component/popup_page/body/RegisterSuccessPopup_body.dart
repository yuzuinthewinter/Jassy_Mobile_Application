import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/success.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/register_info/profile.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  final String successWord;
  Body(this.successWord);

  //TODO: check in the 1st render
  // check profile and language's user data
  // check facereg ?
  // and go to jassy home

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Sucess(
          text: successWord.tr,
        ),
        SizedBox(
          height: size.height * 0.23,
        ),
        RoundButton(
          text: 'NextButton'.tr,
          minimumSize: Size(279, 36),
          //TODO: support send routes to this component
          press: () {
            Navigator.pushNamed(
              context,
              Routes.JassyHome,
            );
          },
        ),
      ],
    );
  }
}
