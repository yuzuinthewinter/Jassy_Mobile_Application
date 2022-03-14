import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style1.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/numeric_numpad.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/register/create_password.dart';
import 'package:flutter_application_1/screens/register/enter_otp.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_application_1/screens/landing/landing_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  final phoneNumberController = TextEditingController();

  bool showLoading = false;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CurvedWidget(
            child: HeaderStyle1(),
          ),
          const HeaderText(
            text: "กรอกเบอร์โทรศัพท์",
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          const DescriptionText(
            text:
                "กรุณากรอกหมายเลขโทรศัพท์ของคุณสำหรับการส่งเลข OTP เพื่อลงทะเบียน",
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          const RequiredTextFieldLabel(
            textLabel: "เบอร์โทรศัพท์",
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(15)],
              decoration: InputDecoration(
                  // hintText: "869077768",
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
                  // prefixIcon: CountryCodePicker(
                  //   initialSelection: "+66",
                  //   countryFilter: const ["+66", "+62", "+82"],
                  // ),
                  // prefix: Text('+66')
              ),
                  
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length < 12) {
                  return "กรอกให้ครบ";
                }
                return null;
              },
              // onSaved: (String? phoneNumber) {
              //   phoneNumber = phoneNumberController.text;
              //   userinfo.phoneNumber = phoneNumber;
              // },
            ),
          ),
          // SizedBox(
          //   height: size.height * 0.25,
          // ),
          Center(
              child: DisableToggleButton(
                  text: "ตกลง",
                  minimumSize: const Size(279, 36),
                  press: () async {
                    setState(() {
                      showLoading = true;
                    });

                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EnterOTP(phoneNumberController.text)));
                    
                  }))
        ],
      ),
    );
  }
}