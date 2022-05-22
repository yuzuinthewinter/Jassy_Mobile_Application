import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/controllers/filter.dart';
import 'package:flutter_application_1/models/filter.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class FilterBody extends StatefulWidget {
  const FilterBody({Key? key}) : super(key: key);

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  final _LanguageChoicesLists = ['Cambodian', 'English', 'Indonesian', 'Japanese', 'Korean', 'Thai',];
  final List<String> _LanguageLevelChoicesLists = [
    "Beginner",
    "Elementary",
    "Intermidiate",
    "Upper Intermidiate",
    "Advanced",
    "Proficiency"
  ];
  final List<String> _GenderChoicesLists = [
    "Male", "Female", "LGBTQ+",
    "FilterNoneGender".tr
  ];

  Filtering filter = Filtering();
  late var _languageIndex;
  var _languageLevelIndex = 0;
  var _genderIndex = 3;
  RangeValues _currentRangeValues = const RangeValues(20, 30);
  FilterController filterController = Get.put(FilterController());

  saveFilter() async {
    await filterController.updateFilter(
        _languageIndex, _languageLevelIndex, _genderIndex, _currentRangeValues);
    Navigator.of(context).popAndPushNamed(Routes.JassyHome, arguments: [0, true, false]);
  }

  resetFilter() {
    setState(() {
      _languageIndex = filterController.languageIndex.toInt();
      _languageLevelIndex = filterController.languageLevelIndex.toInt();
      _genderIndex = filterController.genderIndex.toInt();
      _currentRangeValues = filterController.currentRangeValues.value;
    });
  }

  @override
  void initState() {
    filterController.fetchDefaultFilter();
    super.initState();

    _languageIndex = filterController.languageIndex.toInt();
    _languageLevelIndex = filterController.languageLevelIndex.toInt();
    _genderIndex = filterController.genderIndex.toInt();
    _currentRangeValues = filterController.currentRangeValues.value;

    filter.language = _LanguageChoicesLists[_languageIndex];
    filter.languageLevel = _LanguageLevelChoicesLists[_languageLevelIndex];
    filter.gender = _GenderChoicesLists[_genderIndex];
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
                child: GetX<FilterController>(
                  init: FilterController(),
                  builder: (controller) {
                    return Row(
                      children: List.generate(
                        _LanguageChoicesLists.length,
                        (index) {
                          return ChoiceChip(
                            label: Text(_LanguageChoicesLists[index]),
                            selected: false,
                            onSelected: (selected) {
                              setState(() {
                                _languageIndex = selected
                                    ? index
                                    : controller.languageIndex.toInt();
                                filter.language =
                                    _LanguageChoicesLists[_languageIndex];
                              });
                            },
                            labelStyle: TextStyle(
                                color: _languageIndex == index
                                    ? primaryColor
                                    : controller.languageIndex.toInt() == index
                                        ? greyDark
                                        : greyDark),
                            backgroundColor: _languageIndex == index
                                ? primaryLightest
                                : textLight,
                            selectedColor: _languageIndex == index
                                ? textLight
                                : primaryLightest,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            HeaderText(text: "FilterLevelLang".tr),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetX<FilterController>(
                      init: FilterController(),
                      builder: (controller) {
                        return Row(
                            children: List.generate(
                                _LanguageLevelChoicesLists.length, (index) {
                          return ChoiceChip(
                            label: Text(_LanguageLevelChoicesLists[index]),
                            selected: false,
                            onSelected: (selected) {
                              setState(() {
                                _languageLevelIndex = selected
                                    ? index
                                    : controller.languageLevelIndex.toInt();
                                filter.languageLevel =
                                    _LanguageLevelChoicesLists[
                                        _languageLevelIndex];
                              });
                            },
                            labelStyle: TextStyle(
                                color: _languageLevelIndex == index
                                    ? primaryColor
                                    : controller.languageLevelIndex.toInt() ==
                                            index
                                        ? greyDark
                                        : greyDark),
                            backgroundColor: _languageLevelIndex == index
                                ? primaryLightest
                                : textLight,
                            selectedColor: _languageLevelIndex == index
                                ? textLight
                                : primaryLightest,
                          );
                        }));
                      })),
            ),
            HeaderText(text: "FilterSex".tr),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetX<FilterController>(
                      init: FilterController(),
                      builder: (controller) {
                        return Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(_GenderChoicesLists.length,
                                (index) {
                          return ChoiceChip(
                            label: Text(_GenderChoicesLists[index]),
                            selected: false,
                            onSelected: (selected) {
                              setState(() {
                                _genderIndex = selected
                                    ? index
                                    : controller.genderIndex.toInt();
                                filter.gender =
                                    _GenderChoicesLists[_genderIndex];
                              });
                            },
                            labelStyle: TextStyle(
                                color: _genderIndex == index
                                    ? primaryColor
                                    : controller.genderIndex.toInt() == index
                                        ? greyDark
                                        : greyDark),
                            backgroundColor: _genderIndex == index
                                ? primaryLightest
                                : textLight,
                            selectedColor: _genderIndex == index
                                ? textLight
                                : primaryLightest,
                          );
                        }));
                      })),
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
                            _currentRangeValues = values ==
                                    filterController.currentRangeValues.value
                                ? filterController.currentRangeValues.value
                                : values;
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
