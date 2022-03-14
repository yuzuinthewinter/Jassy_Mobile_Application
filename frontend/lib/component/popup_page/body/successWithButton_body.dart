import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/success.dart';
import 'package:flutter_application_1/screens/register_info/profile.dart';

class Body extends StatelessWidget {
  final String SuccessWord;
  final Widget Path;
  Body(this.SuccessWord, this.Path);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Sucess(text: this.SuccessWord,),
        SizedBox(height: size.height * 0.23,),
        RoundButton(
          text: "ถัดไป", 
          minimumSize: Size(279, 36), 
          press: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Path),
            );
          })
      ],
    );
  }
}