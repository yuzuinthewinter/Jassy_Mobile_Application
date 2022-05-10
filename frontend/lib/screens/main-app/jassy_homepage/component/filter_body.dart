import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class FilterBody extends StatefulWidget {
  const FilterBody({ Key? key }) : super(key: key);

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {

  Filtering filter = Filtering();
  int _languageLevelIndex = 0;
  int _genderIndex = 0;
  final List<String> _LanguageLevelChoicesLists = ["Beginner", "Elementary", "Intermidiate", "Upper Intermidiate", "Advanced", "Proficiency"];
  final List<String> _GenderChoicesLists = ["InfoMale".tr, "InfoFemale".tr, "LGBTQ+", "FilterNoneGenre".tr];

  RangeValues _currentRangeValues = const RangeValues(20, 30);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkCurrentUser();
    this.filter.langguageLevel = _LanguageLevelChoicesLists[0];
    this.filter.gender =_GenderChoicesLists[0];
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
          HeaderText(text: "FilterLevelLang".tr),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_LanguageLevelChoicesLists.length, (index) {
                  return ChoiceChip(
                    label: Text(_LanguageLevelChoicesLists[index]), 
                    selected: _languageLevelIndex == index,
                    onSelected: (value) {
                      setState(() {
                        _languageLevelIndex = value ? index : _languageLevelIndex;
                        if (_languageLevelIndex == null) {
                          _languageLevelIndex = 0;
                        }
                        filter.langguageLevel = _LanguageLevelChoicesLists[_languageLevelIndex];
                      });
                    },
                    labelStyle: TextStyle(
                      color: _languageLevelIndex == index ? primaryColor : greyDark
                    ),
                    backgroundColor: textLight,
                    selectedColor: primaryLightest,
                  );
                })
              ),
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
                children: List.generate(_GenderChoicesLists.length, (index) {
                  return ChoiceChip(
                    label: Text(_GenderChoicesLists[index]), 
                    selected: _genderIndex == index,
                    onSelected: (value) {
                      setState(() {
                        _genderIndex = value ? index : _genderIndex;
                        if (_genderIndex == null) {
                          _genderIndex = 0;
                        }
                        filter.langguageLevel = _GenderChoicesLists[_genderIndex];
                      });
                    },
                    labelStyle: TextStyle(
                      color: _genderIndex == index ? primaryColor : greyDark
                    ),
                    backgroundColor: textLight,
                    selectedColor: primaryLightest,
                  );
                })
              ),
            ),
          ),
          const HeaderText(text: "FilterAge"),
          SliderTheme(
            data: const SliderThemeData(
              valueIndicatorColor: primaryColor,
              showValueIndicator: ShowValueIndicator.always,
              trackHeight: 1.5,
              rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 6),
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
                  const Text("0", style: TextStyle(color: grey),),
                  SizedBox(
                    width: size.width * 0.80,
                    // width: 335,
                    child: RangeSlider(
                      // "Power: ${sliderValue.round().toString()}",
                      values: _currentRangeValues,
                      max: 100,
                      divisions: 100,
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
                  const Text("100", style: TextStyle(color: grey),)
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
                minimumSize: Size(size.width * 0.45, size.height *0.05), 
                press: () {}
              ),
              RoundButton(
                text: "FilterButton".tr, 
                minimumSize: Size(size.width * 0.45, size.height *0.05), 
                press: () {}
              )
            ],
          )
        ]
      ),
    );
  }
  // Widget buildSideLabel() {
  //   final double min = 0;
  //   final double max = 100;
  //   return Container(

  //   );
  // }

}