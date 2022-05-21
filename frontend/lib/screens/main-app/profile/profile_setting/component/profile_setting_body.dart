import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/text/text_field_label.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile_setting/component/edit_profile_picture_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile_setting/component/profile_setting_tabbar.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

// Todo: disable gender
class ProfileSettingBody extends StatefulWidget {
  final user;
  const ProfileSettingBody(this.user, {Key? key}) : super(key: key);

  @override
  State<ProfileSettingBody> createState() => _ProfileSettingBodyState();
}

class _ProfileSettingBodyState extends State<ProfileSettingBody>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  // Type
  NameType nameInfo = NameType();
  InfoType userInfo = InfoType();
  LanguageType language = LanguageType();

  //tab
  late TabController tabController;
  int currentTabIndex = 0;

  // state of data's user
  final List<String> _choicesLists = ["Male", "Female", "LGBTQ+"];

  //controller
  TextEditingController descController = TextEditingController();
  // late FixedExtentScrollController countryScrollController;
  // late FixedExtentScrollController defaultScrollController;
  late FixedExtentScrollController defaultLevelScrollController;
  late FixedExtentScrollController interestScrollController;
  late FixedExtentScrollController interestLevelScrollController;

  //click
  bool isLevelDefaultLanguageClick = false;
  bool isInterestLanguageClick = false;
  bool isLevelInterestLanguageClick = false;

  //check data
  bool isLVdefaultlang = false;
  bool isIntLang = false;
  bool isLVIntlang = false;

  //array data
  final languageItems = ['Thai', 'Korean', 'Indonsian'];
  final languageLevelItems = [
    "Beginner",
    "Elementary",
    "Intermidiate",
    "Upper Intermidiate",
    "Advanced",
    "Proficiency"
  ];

  //default index
  int countryIndex = 0;
  int defaultIndex = 0;
  int defaultLevelIndex = 0;
  int interestIndex = 0;
  int interestLevelIndex = 0;
  int _defaultChoiceIndex = 0;

  //database
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  void updateData() async {
    await users.doc(currentUser!.uid).update({
      'gender': userInfo.gender.toLowerCase(),
      'desc': userInfo.desc,
      'language.levelDefaultLanguage':
          language.levelDefaultLanguage.toLowerCase(),
      'language.interestedLanguage': language.interestedLanguage.toLowerCase(),
      'language.levelInterestedLanguage':
          language.levelInterestedLanguage.toLowerCase(),
    });
    //todo: popup change profile success
    Navigator.of(context).pushNamed(Routes.JassyHome, arguments: 4);
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      onTabChange();
    });
    if (widget.user['gender'].isNotEmpty) {
      userInfo.gender = widget.user['gender'];
    }
    if (widget.user['desc'].isNotEmpty) {
      userInfo.desc = widget.user['desc'];
      descController = TextEditingController(text: widget.user['desc']);
    }
    if (widget.user['language']["levelDefaultLanguage"] != '') {
      isLVdefaultlang = true;
      language.levelDefaultLanguage =
          widget.user['language']["levelDefaultLanguage"];
    }
    if (widget.user['language']["interestedLanguage"] != '') {
      isLVdefaultlang = true;
      language.interestedLanguage =
          widget.user['language']["interestedLanguage"];
    }
    if (widget.user['language']["levelInterestedLanguage"] != '') {
      isLVdefaultlang = true;
      language.levelInterestedLanguage =
          widget.user['language']["levelInterestedLanguage"];
    }

    defaultLevelScrollController =
        FixedExtentScrollController(initialItem: defaultLevelIndex);
    interestScrollController =
        FixedExtentScrollController(initialItem: interestIndex);
    interestLevelScrollController =
        FixedExtentScrollController(initialItem: interestLevelIndex);

    super.initState();
  }

  @override
  void dispose() {
    tabController.addListener(() {
      onTabChange();
    });

    tabController.dispose();
    descController.dispose();

    defaultLevelScrollController.dispose();
    interestScrollController.dispose();
    interestLevelScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        EditProfilePictureWidget(size: size, user: widget.user),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ProfileSettingTabBar(tabController: tabController),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TabBarView(controller: tabController, children: [
                        profileTab(),
                        languageTab(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: DisableToggleButton(
              text: "ProfileSaveChange".tr,
              minimumSize: Size(size.width * 0.8, size.height * 0.05),
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  updateData();
                }
              }),
        ),
      ],
    );
  }

  Widget profileTab() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldLabel(
              textLabel: "${'InfoFirstname'.tr}-${'InfoLastname'.tr}"),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText:
                  StringUtils.capitalize(widget.user['name']["firstname"]) +
                      ' ' +
                      StringUtils.capitalize(widget.user['name']["lastname"]),
              fillColor: grey,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
          ),
          TextFieldLabel(textLabel: "InfoDateBirth".tr),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: widget.user['birthDate'].toString(),
              fillColor: grey,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
          ),
          TextFieldLabel(textLabel: "InfoSex".tr),
          Center(
            child: Wrap(
                spacing: size.width * 0.03,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: List.generate(_choicesLists.length, (index) {
                  return ChoiceChip(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    label: Text(_choicesLists[index]),
                    // ignore: unrelated_type_equality_checks
                    selected: userInfo.gender.toLowerCase() ==
                        _choicesLists[index].toLowerCase(),
                    onSelected: (selected) {
                      userInfo.gender = _choicesLists[index];
                    },
                    backgroundColor: textLight,
                    selectedColor: grey,
                    labelStyle: TextStyle(
                      color: userInfo.gender.toLowerCase() ==
                              _choicesLists[index].toLowerCase()
                          ? greyDark
                          : greyDark,
                    ),
                  );
                })),
          ),
          TextFieldLabel(textLabel: "ProfileDesc".tr),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            controller: descController,
            onChanged: (desc) {
              desc = descController.text;
              userInfo.desc = desc;
            },
            decoration: InputDecoration(
              fillColor: textLight,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget languageTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFieldLabel(textLabel: "InfoCountry".tr),
          TextFormField(
            readOnly: true,
            initialValue: widget.user['country'],
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: languageItems[countryIndex],
              fillColor: grey,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
          ),
          TextFieldLabel(textLabel: "InfoFirstLanguage".tr),
          TextFormField(
            readOnly: true,
            initialValue: widget.user['language']["defaultLanguage"],
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: languageItems[defaultIndex],
              fillColor: grey,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
          ),
          TextFieldLabel(textLabel: "InfoLevelFirstLanguage".tr),
          TextFormField(
            readOnly: true,
            onChanged: (levelDefaultLanguage) {
              defaultLevelIndex = isLevelDefaultLanguageClick
                  ? defaultLevelScrollController.selectedItem
                  : defaultLevelIndex;
              language.levelDefaultLanguage = isLevelDefaultLanguageClick
                  ? languageLevelItems[defaultLevelIndex]
                  : language.levelDefaultLanguage;
            },
            onTap: () {
              isLevelDefaultLanguageClick = true;
              defaultLevelScrollController.dispose;
              defaultLevelScrollController =
                  FixedExtentScrollController(initialItem: defaultLevelIndex);
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: [defaultLanguageLevelPicker()],
                    );
                  });
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: isLevelDefaultLanguageClick
                  ? languageLevelItems[defaultLevelIndex]
                  : language.levelDefaultLanguage,
              fillColor: textLight,
              filled: true,
              suffixIcon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: primaryColor,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
            onSaved: (String? defaultLevel) {
              language.levelDefaultLanguage = isLevelDefaultLanguageClick
                  ? languageLevelItems[defaultLevelIndex]
                  : language.levelDefaultLanguage;
            },
          ),
          TextFieldLabel(textLabel: "InfoLanguageInterest".tr),
          TextFormField(
            readOnly: true,
            onChanged: (interestedLanguage) {
              interestIndex = isInterestLanguageClick
                  ? interestScrollController.selectedItem
                  : interestIndex;
              language.interestedLanguage = isInterestLanguageClick
                  ? languageItems[interestIndex]
                  : language.interestedLanguage;
            },
            onTap: () {
              isInterestLanguageClick = true;
              interestScrollController.dispose;
              interestScrollController =
                  FixedExtentScrollController(initialItem: interestIndex);
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: [interestLanguagePicker()],
                    );
                  });
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: isInterestLanguageClick
                  ? languageItems[interestIndex]
                  : language.interestedLanguage,
              fillColor: textLight,
              filled: true,
              suffixIcon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: primaryColor,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
            onSaved: (String? interestLanguage) {
              language.interestedLanguage = isInterestLanguageClick
                  ? languageItems[interestIndex]
                  : language.interestedLanguage;
            },
          ),
          TextFieldLabel(textLabel: "InfoLevelLanguageInterest".tr),
          TextFormField(
            readOnly: true,
            onChanged: (levelInterestedLanguage) {
              interestLevelIndex = isLevelInterestLanguageClick
                  ? interestLevelScrollController.selectedItem
                  : interestLevelIndex;
              language.levelInterestedLanguage = isLevelInterestLanguageClick
                  ? languageLevelItems[interestLevelIndex]
                  : language.levelInterestedLanguage;
            },
            onTap: () {
              isLevelInterestLanguageClick = true;
              interestLevelScrollController.dispose;
              interestLevelScrollController =
                  FixedExtentScrollController(initialItem: interestLevelIndex);
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: [interestLevelLanguagePicker()],
                    );
                  });
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: isLevelInterestLanguageClick
                  ? languageLevelItems[interestLevelIndex]
                  : language.levelInterestedLanguage,
              fillColor: textLight,
              filled: true,
              suffixIcon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: primaryColor,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
            onSaved: (String? interestLevel) {
              // print(interestLevel);
              language.levelInterestedLanguage = isLevelInterestLanguageClick
                  ? languageLevelItems[interestLevelIndex]
                  : language.levelInterestedLanguage;
            },
          ),
        ],
      ),
    );
  }

  // Widget countryalityPicker() {
  //   return Center(
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 150,
  //           child: CupertinoPicker(
  //             scrollController: countryScrollController,
  //             itemExtent: 40,
  //             children: languageItems
  //                 .map((item) => Center(
  //                       child: Text(
  //                         item,
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                     ))
  //                 .toList(),
  //             onSelectedItemChanged: (value) {
  //               setState(() {
  //                 countryIndex = value;
  //               });
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget defaultLanguagePicker() {
  //   return Center(
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 150,
  //           child: CupertinoPicker(
  //             scrollController: defaultScrollController,
  //             itemExtent: 40,
  //             children: languageItems
  //                 .map((item) => Center(
  //                       child: Text(
  //                         item,
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                     ))
  //                 .toList(),
  //             onSelectedItemChanged: (value) {
  //               setState(() {
  //                 defaultIndex = value;
  //               });
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget defaultLanguageLevelPicker() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: defaultLevelScrollController,
              itemExtent: 40,
              children: languageLevelItems
                  .map((item) => Center(
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList(),
              onSelectedItemChanged: (value) {
                setState(() {
                  defaultLevelIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget interestLanguagePicker() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: interestScrollController,
              itemExtent: 40,
              children: languageItems
                  .map((item) => Center(
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList(),
              onSelectedItemChanged: (value) {
                setState(() {
                  interestIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget interestLevelLanguagePicker() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: interestLevelScrollController,
              itemExtent: 40,
              children: languageLevelItems
                  .map((item) => Center(
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList(),
              onSelectedItemChanged: (value) {
                setState(() {
                  interestLevelIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
