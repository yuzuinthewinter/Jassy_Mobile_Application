import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  final NameType name;
  final InfoType uinfo;
  // ignore: use_key_in_widget_constructors
  const Body(this.name, this.uinfo);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  NameType name = NameType();
  InfoType userInfo = InfoType();
  LanguageType language = LanguageType();

  late FixedExtentScrollController countryScrollController;
  late FixedExtentScrollController defaultScrollController;
  late FixedExtentScrollController defaultLevelScrollController;
  late FixedExtentScrollController interestScrollController;
  late FixedExtentScrollController interestLevelScrollController;

  final languageLevelItems = ['Beginner', 'Intermediate', 'Advance'];
  final languageItems = ['Thai', 'Korean', 'Indonsian'];

  int countryIndex = 0;
  int defaultIndex = 0;
  int defaultLevelIndex = 0;
  int interestIndex = 0;
  int interestLevelIndex = 0;

  var currentUser = FirebaseAuth.instance.currentUser;

  void updateData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    await users.doc(currentUser!.uid).update({
      'name': {
        'firstname': widget.name.firstname,
        'lastname': widget.name.lastname
      },
      'birthDate': widget.uinfo.birthDate,
      'genre': widget.uinfo.genre,
      'country': userInfo.country,
      'language': {
        'defaultLanguage': language.defaultLanguage,
        'levelDefaultLanguage': language.levelDefaultLanguage,
        'interestedLanguage': language.interestedLanguage,
        'levelInterestedLanguage': language.levelInterestedLanguage,
      },
      'isAuth': true,
    });
  }

  @override
  void initState() {
    super.initState();

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
  }

  @override
  void dispose() {
    countryScrollController.dispose();
    defaultScrollController.dispose();
    defaultLevelScrollController.dispose();
    interestScrollController.dispose();
    interestLevelScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CurvedWidget(
            child: HeaderStyle2(),
          ),
          const HeaderText(text: "ข้อมูลภาษา"),
          const DescriptionText(
              text:
                  "คุณไม่สามารถเปลี่ยนสัญชาติและภาษาที่หนึ่งหลังจากนี้ได้ดังนั้นโปรดให้ข้อมูลส่วนบุคคลที่แท้จริง"),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const RequiredTextFieldLabel(textLabel: "คุณเป็นคนประเทศ"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          countryScrollController.dispose;
                          countryScrollController = FixedExtentScrollController(
                              initialItem: countryIndex);
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return CupertinoActionSheet(
                                  actions: [countryalityPicker()],
                                );
                              });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          labelText: languageItems[countryIndex],
                          fillColor: textLight,
                          filled: true,
                          suffixIcon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
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
                  ),
                  const RequiredTextFieldLabel(textLabel: "ภาษาที่หนึ่ง"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        defaultScrollController.dispose;
                        defaultScrollController = FixedExtentScrollController(
                            initialItem: defaultIndex);
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoActionSheet(
                                actions: [defaultLanguagePicker()],
                              );
                            });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        labelText: languageItems[defaultIndex],
                        fillColor: textLight,
                        filled: true,
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
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
                      onSaved: (String? defaultLanguage) {
                        language.defaultLanguage = languageItems[defaultIndex];
                      },
                    ),
                  ),
                  const RequiredTextFieldLabel(textLabel: "ระดับภาษาที่หนึ่ง"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
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
                        labelText: languageLevelItems[defaultLevelIndex],
                        fillColor: textLight,
                        filled: true,
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
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
                  ),
                  const RequiredTextFieldLabel(textLabel: "ภาษาที่สนใจ"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
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
                        labelText: languageItems[interestIndex],
                        fillColor: textLight,
                        filled: true,
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
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
                  ),
                  const RequiredTextFieldLabel(textLabel: "ระดับภาษาที่สนใจ"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
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
                        labelText: languageLevelItems[interestLevelIndex],
                        fillColor: textLight,
                        filled: true,
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
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
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: DisableToggleButton(
              text: "next",
              minimumSize: const Size(279, 36),
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  updateData();
                }
                Navigator.pushNamed(
                  context,
                  Routes.SuccessPage,
                  arguments: 'RegisterSuccess',
                );
              },
            ),
          )
        ],
      ),
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
