import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style1.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();

  CountryCode? countryCode = CountryCode();
  String getCoutryCode = '';

  void getCountry(CountryCode? countryCode) {
    getCoutryCode = countryCode.toString();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CurvedWidget(
            child: HeaderStyle1(),
          ),
          HeaderText(
            text: 'PhonePageFilled'.tr,
          ),
          DescriptionText(
            text: 'PhonePageDesc'.tr,
          ),
          RequiredTextFieldLabel(
            textLabel: 'PhonePagePhoneNumber'.tr,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(9)],
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
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
                  prefixIcon: CountryCodePicker(
                    initialSelection: "+66",
                    countryFilter: const ["+66", "+62", "+82", "+886", "+855", "+81"],
                    onInit: getCountry,
                    onChanged: getCountry,
                    showDropDownButton: true,
                    flagWidth: 25,
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'InfoPleaseFill'.tr;
                } return null;
              },
            ),
          ),
          Spacer(),
          Center(
              child: DisableToggleButton(
                color: phoneNumberController.text.isEmpty ? grey : primaryColor,
            text: "Confirm".tr,
            minimumSize: Size(size.width * 0.8, size.height * 0.05),
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print(getCoutryCode);
                String phone = getCoutryCode + '${phoneNumberController.text}';
                print(phone);
                Navigator.pushNamed(context, Routes.EnterOTP,
                    arguments: [phone, 'PhoneRegisterPage'.tr]);
              }
            },
          )),
          SizedBox(
            height: size.height * 0.04,
          ),
        ],
      ),
    );
  }
}
