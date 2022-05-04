import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChangeLanguagesButton extends StatelessWidget {
  ChangeLanguagesButton({Key? key}) : super(key: key);

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
    return CountryCodePicker(
      initialSelection: listLocale[0],
      countryFilter: listLocale,
      showCountryOnly: true,
      hideMainText: true,
      showDropDownButton: true,
      flagWidth: size.width * 0.07,
      flagDecoration: const BoxDecoration(
          // shape: BoxShape.circle
          ),
      onChanged: onChangeLanguage,
    );
  }
}
