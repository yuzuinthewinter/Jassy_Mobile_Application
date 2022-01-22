import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/component/term_and_policies.dart';
import 'package:flutter_application_1/component/button/icon_button.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          SizedBox(height: size.height * 0.2,),
          IconButtonComponent(
            text: 'ลงทะเบียนด้วยเบอร์โทรศัพท์',
            minimumSize: Size(279, 36),
            iconPicture: SvgPicture.asset('assets/icons/mobile.svg', height: 21,),
            press: () {},
          ),
          IconButtonComponent(
            text: 'ลงทะเบียนด้วย Facebook',
            minimumSize: Size(279, 36),
            iconPicture: SvgPicture.asset('assets/icons/facebook.svg', height: 21,),
            press: () {},
            color: facebook,
          ),
          IconButtonComponent(
            text: 'ลงทะเบียนด้วย Google',
            minimumSize: Size(279, 36),
            iconPicture: SvgPicture.asset('assets/icons/google.svg', height: 21,),
            press: () {},
            color: textLight,
            textColor: greyDarker,
          ),
          SizedBox(height: size.height * 0.05,),
          TermAndPolicies(),
        ],
      ),
    );
  }
}