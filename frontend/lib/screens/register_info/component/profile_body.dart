import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/component/popup_page/successWithButton.dart';
import 'package:flutter_application_1/screens/landing/landing_page.dart';
import 'package:flutter_application_1/screens/register_info/language.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:intl/intl.dart';

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
  final List<String> _choicesLists = ["ชาย", "หญิง", "LGBTQ+"];
  Name name = Name();
  Info userInfo = Info();
  UserSchema user = UserSchema();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  bool isLoading = false;

  var currentUser = FirebaseAuth.instance.currentUser;
  void checkCurrentUser() async {
    setState() {
      isLoading = true;
    }

    if (currentUser != null) {
      isLoading = true;
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SuccessPage('เข้าสู่ระบบสำเร็จ', LandingPage())),
      );
    } else {
      isLoading = false;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    lastnameController.dispose();
    firstNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUser();
    this.userInfo.genre = _choicesLists[0];
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final String formattedDate = DateFormat.yMd().format(_selectedDateTime);
    final selectedText = Text('You selected: $formattedDate');
    return isLoading
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CurvedWidget(
                    child: HeaderStyle2(),
                  ),
                  HeaderText(text: "ข้อมูลส่วนตัว"),
                  DescriptionText(
                      text:
                          "คุณไม่สามารถเปลี่ยนอายุและเพศหลังจากนี้ได้ดังนั้นโปรดให้ข้อมูลส่วนบุคคลที่แท้จริง"),
                  RequiredTextFieldLabel(textLabel: "ชื่อ"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: textLight,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (String? firstname) {
                        firstname = firstNameController.text;
                        name.firstname = firstname;
                      },
                    ),
                  ),
                  RequiredTextFieldLabel(textLabel: "นามสกุล"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: textLight,
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
                  RequiredTextFieldLabel(textLabel: "วันเดือนปีเกิด"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
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
                        labelText: DateFormat.yMd().format(_selectedDateTime),
                        fillColor: textLight,
                        filled: true,
                        suffixIcon: Icon(
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
                      onSaved: (String? birthDate) {
                        birthDate = DateFormat.yMd().format(_selectedDateTime);
                        userInfo.birthDate = birthDate;
                      },
                    ),
                  ),
                  RequiredTextFieldLabel(textLabel: "เพศ"),
                  Center(
                    child: Wrap(
                        // alignment: WrapAlignment.spaceBetween,
                        children: List.generate(_choicesLists.length, (index) {
                      return ChoiceChip(
                        label: Text(_choicesLists[index]),
                        selected: _defaultChoiceIndex == index,
                        onSelected: (value) {
                          setState(() {
                            _defaultChoiceIndex =
                                value ? index : _defaultChoiceIndex;
                            if (_defaultChoiceIndex == null) {
                              _defaultChoiceIndex = 0;
                            }
                            userInfo.genre = _choicesLists[_defaultChoiceIndex];
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
                      text: "next",
                      minimumSize: Size(279, 36),
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterLanguage(name, userInfo)),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }

  void onBirthdayChange(DateTime birthday) {
    setState(() {
      _selectedDateTime = birthday;
    });
  }
}
