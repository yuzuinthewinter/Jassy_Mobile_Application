import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/account_exists_login.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/term_and_policies.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US'), 'code': 'US'},
    {'name': 'ภาษาไทย', 'locale': const Locale('th', 'TH'), 'code': 'TH'},
  ];

  List<String> listLocale = ['TH', 'US'];

  onChangeLanguage(CountryCode? countryCode) async {
    var getCoutryCode = countryCode?.code;
    for (var local in locale) {
      if (getCoutryCode == local['code']) {
        updateLanguage(local['locale']);
      }
    }
  }

  updateLanguage(Locale locale) {
    //TODO: setting delay popup
    Get.back();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: CountryCodePicker(
              initialSelection: listLocale[0],
              countryFilter: listLocale,
              showCountryOnly: true,
              padding: EdgeInsets.only(top: size.height * 0.02),
              hideMainText: true,
              showDropDownButton: true,
              flagWidth: size.width * 0.07,
              flagDecoration: const BoxDecoration(
                  // shape: BoxShape.circle
                  ),
              onChanged: onChangeLanguage,
            ),
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
            style: TextStyle(
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
          AccountExistsLogin(),
          SizedBox(
            height: size.height * 0.07,
          ),
          TermAndPolicies(),
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
