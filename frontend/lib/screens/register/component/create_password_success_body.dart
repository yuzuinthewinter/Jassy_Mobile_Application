import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/success.dart';
import 'package:flutter_application_1/screens/register_info/profile.dart';

class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Sucess(text: "ตั้งค่ารหัสผ่านสำเร็จ",),
        SizedBox(height: size.height * 0.23,),
        RoundButton(
          text: "ถัดไป", 
          minimumSize: Size(279, 36), 
          press: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterProfile()),
            );
          })
      ],
    );
  }
}