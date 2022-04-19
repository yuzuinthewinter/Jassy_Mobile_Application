import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/account_exists_login.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/component/button/change_languages_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/term_and_policies.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: ChangeLanguagesButton(),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          SvgPicture.asset(
            'assets/icons/landing_logo.svg',
            height: size.height * 0.2,
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            'LandingWelcome'.tr, //------------------------------
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: greyDark),
          ),
          SizedBox(
            height: size.height * 0.15,
          ),
          RoundButton(
            text: 'LandingRegister'.tr, //------------------------------
            minimumSize: Size(size.width * 0.8, size.height * 0.05),
            press: () {
              Navigator.pushNamed(context, Routes.RegisterPage);
            },
          ),
          const AccountExistsLogin(),
          SizedBox(
            height: size.height * 0.07,
          ),
          const TermAndPolicies(),
          // TODO: change language button on landing page.
          // ElevatedButton(
          //    onPressed: () {
          //      buildLanguageDialog(context);
          //    },
          //    child: Text('*')),
        ],
      ),
    );
  }
}
