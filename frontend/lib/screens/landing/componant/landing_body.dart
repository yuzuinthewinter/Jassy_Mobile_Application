import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/account_exists_login.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/term_and_policies.dart';
import 'package:flutter_application_1/screens/register/register_page.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.1,),
          SvgPicture.asset(
            'assets/icons/landing_logo.svg',
            height: size.height * 0.2,),
          // ignore: prefer_const_constructors
          SizedBox(height: size.height * 0.05,),
          Text(
            "มาแลกเปลี่ยนความรู้กันเถอะ !",
              style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w500,
              color: greyDark),
          ),
          SizedBox(height: size.height * 0.2,),
          RoundButton(
            text: 'ลงทะเบียนสำหรับผู้ใช้ใหม่',
            minimumSize: Size(279, 36),
            press: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },),
          AccountExistsLogin(),
          SizedBox(height: size.height * 0.05,),
          TermAndPolicies()
        ],
      ),
    );
  }
}
