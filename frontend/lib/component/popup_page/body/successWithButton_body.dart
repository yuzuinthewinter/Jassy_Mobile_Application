import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/success.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/register_info/profile.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  final String SuccessWord;
  Body(this.SuccessWord);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Sucess(
          text: SuccessWord.tr,
        ),
        SizedBox(
          height: size.height * 0.23,
        ),
        RoundButton(
            text: 'NextButton'.tr,
            minimumSize: Size(279, 36),
            press: () {
              //TODO: support send routes to this component
              // Future.delayed(Duration.zero, () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const JassyHome()),
              //   );
              //   Navigator.pushNamed(
              //     context,
              //     Routes.JassyHome,
              //   );
              // Navigator.pushNamed(
              //     context,
              //     Path
              //   );
              // });
            }),
      ],
    );
  }
}
