import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/main_appbar.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/jassy_main_body.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/filter.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/jassy_main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreJassyMain extends StatefulWidget {
  const PreJassyMain({Key? key}) : super(key: key);
  @override
  State<PreJassyMain> createState() => _PreJassyMainBodyState();
}

class _PreJassyMainBodyState extends State<PreJassyMain> {
  var currentUser = FirebaseAuth.instance.currentUser;

  int _languageIndex = 0;
  int _languageLevelIndex = 0;
  final int _genderIndex = 3;

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
    // print(_LanguageChoicesLists[_languageIndex]);
    // print(_LanguageLevelChoicesLists[_languageLevelIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('uid', isEqualTo: currentUser!.uid)
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const SizedBox.shrink();
          } else {
            var user = snapshot.data!.docs[0];

            int userAge =
                calculateAge(DateTime.parse(user['birthDate'].toString()));

            _currentRangeValues = RangeValues(userAge - 3, userAge + 3);

            _LanguageChoicesLists.forEachIndexed((index, lang) => {
                  if (user['language']['interestedLanguage'].toLowerCase() ==
                      _LanguageChoicesLists[index].toLowerCase())
                    {_languageIndex = index}
                });
            _LanguageLevelChoicesLists.forEachIndexed(
              (index, level) => {
                if (user['language']['levelInterestedLanguage'].toLowerCase() ==
                    _LanguageLevelChoicesLists[index].toLowerCase())
                  {
                    if (index > 3)
                      {_languageLevelIndex = 5}
                    else
                      {_languageLevelIndex = index + 2}
                  }
              },
            );
            saveFilter();
            return const JassyMain();
          }
        });
  }
}
