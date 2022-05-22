import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/models/filter.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  var filter = <Filter>[].obs;
  var filterIndex = <FilterIndex>[].obs;

  var languageIndex = 0.obs;
  var languageLevelIndex = 0.obs;
  var genderIndex = 3.obs;
  Rx<RangeValues> currentRangeValues = RangeValues(20, 30).obs;

  var currentUser = FirebaseAuth.instance.currentUser;

  final _LanguageChoicesLists = [
    'Cambodian',
    'English',
    'Indonesian',
    'Japanese',
    'Korean',
    'Thai',
  ];
  final List<String> _LanguageLevelChoicesLists = [
    "Beginner",
    "Elementary",
    "Intermidiate",
    "Upper Intermidiate",
    "Advanced",
    "Proficiency"
  ];
  final List<String> _GenderChoicesLists = [
    "Male",
    "Female",
    "LGBTQ+",
    "FilterNoneGender".tr
  ];

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  @override
  void onInit() {
    fetchDefaultFilter();
    super.onInit;
  }

  updateFilter(langIndex, langlvIndex, genderindex, currentRange) {
    languageIndex.value = langIndex;
    languageLevelIndex.value = langlvIndex;
    genderIndex.value = genderindex;
    currentRangeValues.value = currentRange;
    update();
  }

  fetchFilter() {
    languageIndex.obs;
    languageLevelIndex.obs;
    genderIndex.obs;
    currentRangeValues.obs;
  }

  fetchDefaultFilter() async {
    var queryUser = users.where('uid', isEqualTo: currentUser!.uid);
    var snapshot = await queryUser.get();

    if (snapshot.docs.isNotEmpty) {
      final user = snapshot.docs[0];

      int userAge = calculateAge(DateTime.parse(user['birthDate'].toString()));
      if (userAge <= 17) {
        currentRangeValues = RangeValues(15, 20).obs;
      } else if (userAge >= 58) {
        currentRangeValues = RangeValues(55, 60).obs;
      } else {
        currentRangeValues = RangeValues(userAge - 3, userAge + 3).obs;
      }

      _LanguageChoicesLists.forEachIndexed((index, lang) => {
            if (user['language']['interestedLanguage'].toLowerCase() ==
                _LanguageChoicesLists[index].toLowerCase())
              {languageIndex = index.obs}
          });
      _LanguageLevelChoicesLists.forEachIndexed(
        (index, level) => {
          if (user['language']['levelInterestedLanguage'].toLowerCase() ==
              _LanguageLevelChoicesLists[index].toLowerCase())
            {
              if (index > 3)
                {languageLevelIndex = 5.obs}
              else
                {languageLevelIndex = (index + 2).obs}
            }
        },
      );
      update();
    }
  }
}
