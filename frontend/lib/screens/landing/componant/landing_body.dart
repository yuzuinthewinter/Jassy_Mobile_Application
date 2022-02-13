import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../component/account_exists_login.dart';
import '../../../component/background.dart';
import '../../../component/button/round_button.dart';
import '../../../component/term_and_policies.dart';
import '../../../theme/index.dart';
import '../../register/register_page.dart';

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
              MaterialPageRoute(builder: (context) => const RegisterPage()),
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
