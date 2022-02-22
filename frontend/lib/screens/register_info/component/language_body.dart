import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';


class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Name name = Name();
  Info userInfo = Info();
  User user = User();
  late FixedExtentScrollController nationScrollController;
  late FixedExtentScrollController motherScrollController;
  late FixedExtentScrollController motherLevelScrollController;
  late FixedExtentScrollController interestScrollController;
  late FixedExtentScrollController interestLevelScrollController;

  final languageLevelItems = ['beginner', 'intermediate', 'Advance'];
  final languageItems = ['ไทย', 'korean', 'Indonsian'];

  int nationIndex = 0;
  int motherIndex = 0;
  int motherLevelIndex = 0;
  int interestIndex = 0;
  int interestLevelIndex = 0;

  @override
  void initState() {
    super.initState();

    nationScrollController = FixedExtentScrollController(initialItem: nationIndex);
    motherScrollController = FixedExtentScrollController(initialItem: motherIndex);
    motherLevelScrollController = FixedExtentScrollController(initialItem: motherLevelIndex);
    interestScrollController = FixedExtentScrollController(initialItem: interestIndex);
    interestLevelScrollController = FixedExtentScrollController(initialItem: interestLevelIndex);
  }

  @override
  void dispose() {
    nationScrollController.dispose();
    motherScrollController.dispose();
    motherLevelScrollController.dispose();
    interestScrollController.dispose();
    interestLevelScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CurvedWidget(
              child: HeaderStyle2(),
            ),
            HeaderText(text: "ข้อมูลภาษา"),
            DescriptionText(text: "คุณไม่สามารถเปลี่ยนสัญชาติและภาษาแม่หลังจากนี้ได้ดังนั้นโปรดให้ข้อมูลส่วนบุคคลที่แท้จริง"),
            RequiredTextFieldLabel(textLabel: "คุณเป็นคนประเทศ"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    nationScrollController.dispose;
                    nationScrollController = FixedExtentScrollController(initialItem: nationIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          nationalityPicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageItems[nationIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  // onSaved: (String? birthDate) {
                  //   birthDate = DateFormat.yMd().format(_selectedDateTime);
                  //   userInfo.birthDate = birthDate;
                  // },
                ),
            ),
            RequiredTextFieldLabel(textLabel: "ภาษาแม่"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    motherScrollController.dispose;
                    motherScrollController = FixedExtentScrollController(initialItem: motherIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          motherLanguagePicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageItems[motherIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  // onSaved: (String? birthDate) {
                  //   birthDate = DateFormat.yMd().format(_selectedDateTime);
                  //   userInfo.birthDate = birthDate;
                  // },
                ),
            ),
            RequiredTextFieldLabel(textLabel: "ระดับภาษาแม่"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    motherLevelScrollController.dispose;
                    motherLevelScrollController = FixedExtentScrollController(initialItem: motherLevelIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          motherLanguageLevelPicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageLevelItems[motherLevelIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  // onSaved: (String? birthDate) {
                  //   birthDate = DateFormat.yMd().format(_selectedDateTime);
                  //   userInfo.birthDate = birthDate;
                  // },
                ),
            ),
            RequiredTextFieldLabel(textLabel: "ภาษาที่สนใจ"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    interestScrollController.dispose;
                    interestScrollController = FixedExtentScrollController(initialItem: interestIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          interestLanguagePicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageItems[interestIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  // onSaved: (String? birthDate) {
                  //   birthDate = DateFormat.yMd().format(_selectedDateTime);
                  //   userInfo.birthDate = birthDate;
                  // },
                ),
            ),
            RequiredTextFieldLabel(textLabel: "ระดับภาษาที่สนใจ"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    interestLevelScrollController.dispose;
                    interestLevelScrollController = FixedExtentScrollController(initialItem: interestLevelIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          interestLevelLanguagePicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageLevelItems[interestLevelIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  // onSaved: (String? birthDate) {
                  //   birthDate = DateFormat.yMd().format(_selectedDateTime);
                  //   userInfo.birthDate = birthDate;
                  // },
                ),
            ),
            Center(
              child: DisableToggleButton(
                text: "next",
                minimumSize: Size(279, 36),
                press: () {
                 
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const EnterOTP()),
                // );
                // }    
              },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget nationalityPicker () {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: nationScrollController,
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
                  this.nationIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }

  Widget motherLanguagePicker () {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: motherScrollController,
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
                  this.motherIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }
  
  Widget motherLanguageLevelPicker () {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: motherLevelScrollController,
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
                  this.motherLevelIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }

  Widget interestLanguagePicker () {
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
                  this.interestIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }

  Widget interestLevelLanguagePicker () {
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
                  this.interestLevelIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }
}