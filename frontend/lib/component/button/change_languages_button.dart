import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChangeLanguagesButton extends StatefulWidget {
  const ChangeLanguagesButton({Key? key}) : super(key: key);
  @override
  State<ChangeLanguagesButton> createState() => _ChangeLanguagesButton();
}

class _ChangeLanguagesButton extends State<ChangeLanguagesButton> {
  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US'), 'code': 'US'},
    {'name': 'ภาษาไทย', 'locale': const Locale('th', 'TH'), 'code': 'TH'},
  ];

  List<String> listLocale = ['TH', 'US'];
  late String defaultLocale = 'TH';

  onChangeLanguage(CountryCode? countryCode) {
    var getCoutryCode = countryCode?.code;
    setState(() {
      for (var local in locale) {
        if (getCoutryCode == local['code']) {
          defaultLocale = local['code'];
          updateLanguage(local['locale']);
        }
      }
    });
  }

  @override
  void initState() {
    for (var local in locale) {
      if (Get.locale == local['locale']) {
        defaultLocale = local['code'];
      }
    }
    super.initState();
  }

  updateLanguage(locale) {
    //TODO: setting popup success
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CountryCodePicker(
      onChanged: onChangeLanguage,
      initialSelection: defaultLocale,
      countryFilter: listLocale,
      showCountryOnly: true,
      hideMainText: true,
      showDropDownButton: true,
      flagWidth: size.width * 0.07,
      flagDecoration: const BoxDecoration(
          // shape: BoxShape.circle
          ),
    );
  }
}
