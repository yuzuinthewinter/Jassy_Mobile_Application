import 'package:flutter/material.dart';
import 'package:flutter_application_1/componant/background.dart';
import 'package:flutter_application_1/componant/round_button.dart';
import 'package:flutter_application_1/componant/term_and_policies.dart';
import 'package:flutter_application_1/componant/text_button.dart';
import 'package:flutter_application_1/constants.dart';

class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // ignore: prefer_const_constructors
          Text(
            "มาแลกเปลี่ยนความรู้กันเถอะ !",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w500,
              color: grey),
          ),
          // SizedBox(height: size.height * 0.5,),
          RoundButton(
            text: 'ลงทะเบียนสำหรับผู้ใช้ใหม่',
            minimumSize: Size(279, 36),
            press: () => {},),
          TextLinkButton(
            text: 'มีบัญชีผู้ใช้อยู่แล้ว',
            press: () => {},
          ),
          TermAndPolicies()
        ],
      ),
    );
  }
}
