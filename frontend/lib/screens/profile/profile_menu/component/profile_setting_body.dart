import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/text/text_field_label.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/edit_profile_picture_widget.dart';
import 'package:flutter_application_1/screens/profile/profile_menu/component/profile_setting_tabbar.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

// Todo: disable gender
class ProfileSettingBody extends StatefulWidget {
  const ProfileSettingBody({ Key? key }) : super(key: key);

  @override
  State<ProfileSettingBody> createState() => _ProfileSettingBodyState();
}

class _ProfileSettingBodyState extends State<ProfileSettingBody> with TickerProviderStateMixin{

  late TabController tabController;
  int currentTabIndex = 0;
  InfoType userInfo = InfoType();
  int _defaultChoiceIndex = 0;

  // state of data's user
  final List<String> _choicesLists = ["Male".tr, "Female".tr, "LGBTQ+".tr];

  LanguageType language = LanguageType();
  late FixedExtentScrollController countryScrollController;
  late FixedExtentScrollController defaultScrollController;
  late FixedExtentScrollController defaultLevelScrollController;
  late FixedExtentScrollController interestScrollController;
  late FixedExtentScrollController interestLevelScrollController;

  bool isLevelDefaultLanguageClick = false;
  bool isInterestLanguageClick = false;
  bool isLevelInterestLanguageClick = false;

  final languageLevelItems = ['Beginner', 'Intermediate', 'Advance'];
  final languageItems = ['Thai', 'Korean', 'Indonsian'];

  int countryIndex = 0;
  int defaultIndex = 0;
  int defaultLevelIndex = 0;
  int interestIndex = 0;
  int interestLevelIndex = 0;


  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
      print(currentTabIndex);
    });
  }

  @override
  void initState() {
    userInfo.genre = _choicesLists[0];

    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      onTabChange();
    });
  
    countryScrollController =
        FixedExtentScrollController(initialItem: countryIndex);
    defaultScrollController =
        FixedExtentScrollController(initialItem: defaultIndex);
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

    countryScrollController.dispose();
    defaultScrollController.dispose();
    defaultLevelScrollController.dispose();
    interestScrollController.dispose();
    interestLevelScrollController.dispose();

    super.dispose();
  }

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('uid', isNotEqualTo: currentUser!.uid)
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
            var user = snapshot.data!.docs[0];
            return EditProfilePictureWidget(size: size, user: user);
          }
        ),        
        ProfileSettingTabBar(tabController: tabController),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: TabBarView(
              controller: tabController,
              children: [
                // Profile Tab information
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<QuerySnapshot>(
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
                            var user = snapshot.data!.docs;
                            if (user.isEmpty) {
                              return const Text('Please field your infomation!');
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldLabel(textLabel: "ชื่อ-นามสกุล"),
                                TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: user[0]['name']['firstname'].toString() + ' ' + user[0]['name']['lastname'].toString(),
                                      fillColor: grey,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide:
                                              const BorderSide(color: textLight, width: 0.0)),
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
                                const TextFieldLabel(textLabel: "วันเดือนปีเกิด"),
                                TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: user[0]['birthDate'].toString(),
                                      fillColor: grey,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide:
                                              const BorderSide(color: textLight, width: 0.0)),
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
                                const TextFieldLabel(textLabel: "เพศ"),
                                Center(
                                  child: Wrap(
                                      spacing: size.width * 0.03,
                                      alignment: WrapAlignment.spaceBetween,
                                      runAlignment: WrapAlignment.spaceBetween,
                                      children:
                                          List.generate(_choicesLists.length, (index) {
                                        return ChoiceChip(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.04),
                                          label: Text(_choicesLists[index]),
                                          selected: _defaultChoiceIndex == index,
                                          onSelected: (value) {
                                            setState(() {
                                              _defaultChoiceIndex =
                                                  value ? index : _defaultChoiceIndex;
                                              _defaultChoiceIndex;
                                              userInfo.genre =
                                                  _choicesLists[_defaultChoiceIndex];
                                            });
                                          },
                                          backgroundColor: textLight,
                                          selectedColor: primaryLightest,
                                          labelStyle: TextStyle(
                                            color: _defaultChoiceIndex == index
                                                ? primaryColor
                                                : greyDark,
                                          ),
                                        );
                                      })),
                                ),
                                const TextFieldLabel(textLabel: "คำบรรยายของคุณ"),
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  // readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: user[0]['desc'].toString(),
                                      fillColor: textLight,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide:
                                              const BorderSide(color: textLight, width: 0.0)),
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
                            );
                          },
                      ),
                    ],
                  ),
                ),
                // Language Tab information
                StreamBuilder<QuerySnapshot>(
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
                    var user = snapshot.data!.docs;
                    if (user.isEmpty) {
                      return const Text('Please field your infomation!');
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const TextFieldLabel(textLabel: "คุณเป็นคนประเทศ"),
                          TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                hintText: user[0]['country'].toString(),
                                fillColor: grey,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        color: textLight, width: 0.0)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: textLight),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: textLight),
                                ),
                              ),
                              onSaved: (String? country) {
                                userInfo.country = languageItems[countryIndex];
                              }),
                          const TextFieldLabel(textLabel: "ภาษาแม่"),
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              hintText: user[0]['language']['defaultLanguage'].toString(),
                              fillColor: grey,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide:
                                      const BorderSide(color: textLight, width: 0.0)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(color: textLight),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(color: textLight),
                              ),
                            ),
                            onSaved: (String? defaultLanguage) {
                              language.defaultLanguage = languageItems[defaultIndex];
                            },
                          ),
                          const TextFieldLabel(textLabel: "ระดับภาษาแม่"),
                          TextFormField(
                            readOnly: true,
                            onTap: () {
                              isLevelDefaultLanguageClick = true;
                              defaultLevelScrollController.dispose;
                              defaultLevelScrollController =
                                  FixedExtentScrollController(
                                      initialItem: defaultLevelIndex);
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoActionSheet(
                                      actions: [defaultLanguageLevelPicker()],
                                    );
                                  });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              hintText: isLevelDefaultLanguageClick ? languageLevelItems[defaultLevelIndex] : user[0]['language']['levelDefaultLanguage'].toString(),
                              fillColor: textLight,
                              filled: true,
                              suffixIcon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: primaryColor,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide:
                                      const BorderSide(color: textLight, width: 0.0)),
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
                              language.levelDefaultLanguage =
                                  languageLevelItems[defaultLevelIndex];
                            },
                          ),
                          const TextFieldLabel(textLabel: "ภาษาที่สนใจ"),
                          TextFormField(
                            readOnly: true,
                            onTap: () {
                              isInterestLanguageClick = true;
                              interestScrollController.dispose;
                              interestScrollController = FixedExtentScrollController(
                                  initialItem: interestIndex);
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoActionSheet(
                                      actions: [interestLanguagePicker()],
                                    );
                                  });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              hintText: isInterestLanguageClick ? languageItems[interestIndex] : user[0]['language']['interestedLanguage'].toString(),
                              fillColor: textLight,
                              filled: true,
                              suffixIcon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: primaryColor,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide:
                                      const BorderSide(color: textLight, width: 0.0)),
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
                              language.interestedLanguage =
                                  languageItems[interestIndex];
                            },
                          ),
                          const TextFieldLabel(textLabel: "ระดับภาษาที่สนใจ"),
                          TextFormField(
                            readOnly: true,
                            onTap: () {
                              isLevelInterestLanguageClick = true;
                              interestLevelScrollController.dispose;
                              interestLevelScrollController =
                                  FixedExtentScrollController(
                                      initialItem: interestLevelIndex);
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoActionSheet(
                                      actions: [interestLevelLanguagePicker()],
                                    );
                                  });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              hintText: isLevelInterestLanguageClick ? languageLevelItems[interestLevelIndex] : user[0]['language']['levelInterestedLanguage'].toString(),
                              fillColor: textLight,
                              filled: true,
                              suffixIcon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: primaryColor,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide:
                                      const BorderSide(color: textLight, width: 0.0)),
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
                              language.levelInterestedLanguage =
                                  languageLevelItems[interestLevelIndex];
                            },
                          ),
                        ],
                      ),
                    );
                })
              ]
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015,),
        Center(
          child: RoundButton(
          text: "บันทึกการเปลี่ยนแปลง", 
          minimumSize: Size(size.width * 0.8, size.height * 0.05), 
          press: () {}
          ),
        ),
        SizedBox(height: size.height * 0.02,)
      ],
    );
  }

  Widget countryalityPicker() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: countryScrollController,
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
                  countryIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget defaultLanguagePicker() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: defaultScrollController,
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
                  defaultIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

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