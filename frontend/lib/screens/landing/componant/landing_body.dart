import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/account_exists_login.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/term_and_policies.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/constants/translations.dart';
import 'package:flutter_application_1/screens/register/register_page.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'ภาษาไทย', 'locale': Locale('th', 'TH')},
  ];

  updateLanguage(Locale locale) {
    //TODO: setting delay popup
    // Future.delayed(const Duration(milliseconds: 500));
    Get.back();
    Get.updateLocale(locale);
  }

  //TODO: pls re-design change languages button
  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          print(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
            height: size.height * 0.2,
          ),
          RoundButton(
            text: 'LandingRegister'.tr, //------------------------------
            minimumSize: Size(339, 36),
            press: () {
              Navigator.pushNamed(context, Routes.RegisterPage);
            },
          ),
          AccountExistsLogin(),
          SizedBox(
            height: size.height * 0.05,
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
