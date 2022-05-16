import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterBody extends StatefulWidget {
  const FilterBody({Key? key}) : super(key: key);

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  //defined data
  final _LanguageChoicesLists = ['Thai', 'Korean', 'Indonsian'];
  final List<String> _LanguageLevelChoicesLists = [
    "Beginner",
    "Elementary",
    "Intermidiate",
    "Upper Intermidiate",
    "Advanced",
    "Proficiency"
  ];
  final List<String> _GenderChoicesLists = [
    "InfoMale".tr,
    "InfoFemale".tr,
    "LGBTQ+",
    "FilterNoneGender".tr
  ];

  //defined data index
  late int _languageIndex;
  late int _languageLevelIndex;
  late int _genderIndex;
  RangeValues _currentRangeValues = const RangeValues(20, 30);

  saveFilter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('filter', [
      _LanguageChoicesLists[_languageIndex],
      _LanguageLevelChoicesLists[_languageLevelIndex],
      _GenderChoicesLists[_genderIndex],
      _currentRangeValues.start.round().toString(),
      _currentRangeValues.end.round().toString(),
    ]);
    await prefs.setStringList('filterIndex', [
      _languageIndex.toString(),
      _languageLevelIndex.toString(),
      _genderIndex.toString(),
      _currentRangeValues.start.round().toString(),
      _currentRangeValues.end.round().toString(),
    ]);
    Navigator.of(context).pop();
  }

  resetFilter() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? filter = prefs.getStringList('filter');
    final List<String>? filterIndex = prefs.getStringList('filterIndex');
    setState(() {
      _languageIndex = filterIndex![0] as int;
      _languageLevelIndex = filterIndex[1] as int;
      _genderIndex = filterIndex[2] as int;
      _currentRangeValues =
          RangeValues(filterIndex[3] as double, filterIndex[4] as double);

      filter![0] = _LanguageChoicesLists[filterIndex[0] as int];
      filter[1] = _LanguageLevelChoicesLists[filterIndex[1] as int];
      filter[2] = _GenderChoicesLists[filterIndex[2] as int];
    });
  }

  getSetState() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? filter = prefs.getStringList('filter');
    final List<String>? filterIndex = prefs.getStringList('filterIndex');

    _languageIndex = filterIndex![0] as int;
    _languageLevelIndex = filterIndex[1] as int;
    _genderIndex = filterIndex[2] as int;
    _currentRangeValues =
        RangeValues(filterIndex[3] as double, filterIndex[4] as double);

    filter![0] = _LanguageChoicesLists[filterIndex[0] as int];
    filter[1] = _LanguageLevelChoicesLists[filterIndex[1] as int];
    filter[2] = _GenderChoicesLists[filterIndex[2] as int];
  }

  @override
  void initState() {
    // TODO: implement initState 
    getSetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 20),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(text: "FilterLang".tr),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children:
                        List.generate(_LanguageChoicesLists.length, (index) {
                  return ChoiceChip(
                    label: Text(_LanguageChoicesLists[index]),
                    selected: _languageIndex == index,
                    onSelected: (value) {
                      setState(() {
                        _languageIndex = value ? index : _languageIndex;
                        if (_languageIndex == null) {
                          _languageIndex = 0;
                        }
                        // filter.language = _LanguageChoicesLists[_languageIndex];
                      });
                    },
                    labelStyle: TextStyle(
                        color:
                            _languageIndex == index ? primaryColor : greyDark),
                    backgroundColor: textLight,
                    selectedColor: primaryLightest,
                  );
                })),
              ),
            ),
            HeaderText(text: "FilterLevelLang".tr),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(_LanguageLevelChoicesLists.length,
                        (index) {
                  return ChoiceChip(
                    label: Text(_LanguageLevelChoicesLists[index]),
                    selected: _languageLevelIndex == index,
                    onSelected: (value) {
                      setState(() {
                        _languageLevelIndex =
                            value ? index : _languageLevelIndex;
                        if (_languageLevelIndex == null) {
                          _languageLevelIndex = 0;
                        }
                        // filter.languageLevel =
                        //     _LanguageLevelChoicesLists[_languageLevelIndex];
                      });
                    },
                    labelStyle: TextStyle(
                        color: _languageLevelIndex == index
                            ? primaryColor
                            : greyDark),
                    backgroundColor: textLight,
                    selectedColor: primaryLightest,
                  );
                })),
              ),
            ),
            HeaderText(text: "FilterSex".tr),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        List.generate(_GenderChoicesLists.length, (index) {
                  return ChoiceChip(
                    label: Text(_GenderChoicesLists[index]),
                    selected: _genderIndex == index,
                    onSelected: (value) {
                      setState(() {
                        _genderIndex = value ? index : _genderIndex;
                        if (_genderIndex == null) {
                          _genderIndex = 0;
                        }
                        // filter.gender = _GenderChoicesLists[_genderIndex];
                      });
                    },
                    labelStyle: TextStyle(
                        color: _genderIndex == index ? primaryColor : greyDark),
                    backgroundColor: textLight,
                    selectedColor: primaryLightest,
                  );
                })),
              ),
            ),
            HeaderText(text: "FilterAge".tr),
            SliderTheme(
              data: const SliderThemeData(
                valueIndicatorColor: primaryColor,
                showValueIndicator: ShowValueIndicator.always,
                trackHeight: 1.5,
                rangeThumbShape:
                    RoundRangeSliderThumbShape(enabledThumbRadius: 6),
                thumbColor: primaryColor,
                activeTrackColor: primaryColor,
                inactiveTrackColor: grey,
                activeTickMarkColor: Colors.transparent,
                inactiveTickMarkColor: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "15",
                      style: TextStyle(color: grey),
                    ),
                    SizedBox(
                      width: size.width * 0.80,
                      // width: 335,
                      child: RangeSlider(
                        // "Power: ${sliderValue.round().toString()}",
                        values: _currentRangeValues,
                        min: 15,
                        max: 60,
                        divisions: 46,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        // activeColor: primaryColor,
                        // inactiveColor: greyLight,
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                    ),
                    const Text(
                      "60",
                      style: TextStyle(color: grey),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButtonComponent(
                    text: "FilterReset".tr,
                    minimumSize: Size(size.width * 0.45, size.height * 0.05),
                    press: () {
                      resetFilter();
                    }),
                RoundButton(
                    text: "FilterButton".tr,
                    minimumSize: Size(size.width * 0.45, size.height * 0.05),
                    press: () {
                      saveFilter();
                    })
              ],
            )
          ]),
    );
  }
  // Widget buildSideLabel() {
  //   final double min = 0;
  //   final double max = 100;
  //   return Container(

  //   );
  // }

}
