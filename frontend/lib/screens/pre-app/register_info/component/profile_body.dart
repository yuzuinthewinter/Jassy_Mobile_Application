import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/component/popup_page/successWithButton.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _selectedDateTime = DateTime.now();
  int _defaultChoiceIndex = 0;

  // state of data's user
  final List<String> role = ["User", "Premium", "Admin"];
  final List<String> _choicesLists = ["Male", "Female", "LGBTQ+"];
  NameType name = NameType();
  InfoType userInfo = InfoType();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    lastnameController.dispose();
    firstNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userInfo.gender = _choicesLists[0];
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final String formattedDate = DateFormat.yMd().format(_selectedDateTime);
    final selectedText = Text('You selected: $formattedDate');
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? Center(
            child: Lottie.asset("assets/images/loading.json"),
          )
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CurvedWidget(child: HeaderStyle2()),
                HeaderText(text: "InfoHeader".tr),
                DescriptionText(text: "InfoDesc".tr),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RequiredTextFieldLabel(textLabel: "InfoFirstname".tr),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20.0),
                          child: TextFormField(
                            controller: firstNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "InfoFirstname".tr,
                              hintStyle: const TextStyle(color: greyDark),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              fillColor: textLight,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'InfoPleaseFill'.tr;
                              }
                              return null;
                            },
                            onSaved: (String? firstname) {
                              firstname = firstNameController.text;
                              name.firstname = firstname;
                            },
                          ),
                        ),
                        RequiredTextFieldLabel(textLabel: "InfoLastname".tr),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "InfoLastname".tr,
                              hintStyle: const TextStyle(color: greyDark),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              fillColor: textLight,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: lastnameController,
                            onChanged: (String lastname) {
                              lastname = lastnameController.text;
                              name.lastname = lastname;
                            },
                          ),
                        ),
                        RequiredTextFieldLabel(textLabel: "InfoDateBirth".tr),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20.0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext builder) {
                                    return Container(
                                        height: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .height /
                                            3,
                                        child: CupertinoDatePicker(
                                          initialDateTime: DateTime.now(),
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: onBirthdayChange,
                                        ));
                                  });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              labelText:
                                  DateFormat.yMd().format(_selectedDateTime),
                              hintText: DateFormat.yMd().format(DateTime.now()),
                              hintStyle: const TextStyle(color: greyDark),
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
                            onSaved: (String? birthDate) {
                              final DateFormat formatter =
                                  DateFormat('yyyy-MM-dd');
                              birthDate = formatter.format(_selectedDateTime);
                              userInfo.birthDate = birthDate;
                            },
                            validator: (String? birthDate) {
                              final DateFormat formatter =
                                  DateFormat('yyyy-MM-dd');
                              birthDate = formatter.format(_selectedDateTime);
                              int age = calculateAge(DateTime.parse(birthDate));
                              if (age < 15) {
                                return 'ValidateAge'.tr;
                              } return null;
                            },
                          ),
                        ),
                        RequiredTextFieldLabel(textLabel: "InfoSex".tr),
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
                                      if (_defaultChoiceIndex == null) {
                                        _defaultChoiceIndex = 0;
                                      }
                                      userInfo.gender =
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
                        Center(
                          child: DisableToggleButton(
                            color: firstNameController.text.isEmpty || lastnameController.text.isEmpty ? grey : primaryColor,
                            text: "NextButton".tr,
                            minimumSize: Size(size.width * 0.8, size.height * 0.05),
                            press: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.pushNamed(context, Routes.RegisterLanguage,
                                    arguments: [name, userInfo]);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void onBirthdayChange(DateTime birthday) {
    setState(() {
      _selectedDateTime = birthday;
    });
  }
}
