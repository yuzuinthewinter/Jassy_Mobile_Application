import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/button/icon_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style3.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/text/no_account_register.dart';
import 'package:flutter_application_1/component/text/term_and_policies.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/forgot_password/forgot_password.dart';
import 'package:flutter_application_1/screens/register/phone_register.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/theme/index.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  User user = User();
  final phoneNumberController = TextEditingController();
  bool isHiddenPassword = true;
  RegExp regex = RegExp("(?=.*[A-Z])(?=.*[a-z])(?=.*?[!@#\$&*~.]).{8,}");
  TextEditingController passwordController = TextEditingController();

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
            child: HeaderStyle3()
          ),
          HeaderText(text: "ยินดีต้อนรับการกลับมา !"),
          DescriptionText(text: "เข้าสู่ระบบเพื่อเริ่มต้นการแลกเปลี่ยนภาษาของคุณ"),
          SizedBox(height: size.height * 0.03,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: Row(
              children: [
                IconButtonComponent(
                  text: "Google", 
                  minimumSize: Size(163, 36), 
                  press: () {}, 
                  iconPicture: SvgPicture.asset("assets/icons/google.svg", height: 21),
                  color: textLight,
                  textColor: greyDarker,
                ),
                IconButtonComponent(
                  text: "Facebook", 
                  minimumSize: Size(163, 36), 
                  press: () {}, 
                  iconPicture: SvgPicture.asset("assets/icons/facebook.svg", height: 21),
                  color: facebookColor,
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.01,),
          Center(child: Text("หรือเข้าสู่ระบบด้วย", style: TextStyle(color: greyDark),)),
          SizedBox(height: size.height * 0.01,),
          RequiredTextFieldLabel(textLabel: "เบอร์โทรศัพท์"),
          SizedBox(height: size.height * 0.01,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(    
              controller: phoneNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(9)],
                decoration: InputDecoration(
                  // hintText: "869077768",
                  fillColor: textLight,
                  filled: true,
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
                  prefixIcon: CountryCodePicker(
                    initialSelection: "+66",
                    countryFilter: const ["+66", "+62", "+82"],
                    )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }else if (value.length < 9) {
                    return "กรอกให้ครบ";
                  }
                  return null;
                },
                onSaved: (String? phoneNumber) {
                  phoneNumber = phoneNumberController.text;
                  user.phoneNumber = phoneNumber;
                },
              ),
          ),
          SizedBox(height: size.height * 0.01,),
          RequiredTextFieldLabel(textLabel: "รหัสผ่าน"),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(
                controller: passwordController,
                obscureText: isHiddenPassword,
                keyboardType: TextInputType.text,
                inputFormatters: [LengthLimitingTextInputFormatter(9)],
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: _togglePasswordView,
                    child: isHiddenPassword? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                    ),
                  fillColor: textLight,
                  // hintText: "กรุณากรอก",
                  filled: true,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }else if (!regex.hasMatch(value)){
                    return "กรุณากรอกตามpattern";
                  }
                  return null;
                },
                onSaved: (String? password) {
                  user.password = password!;
                },
              ),
            ),
            SizedBox(height: size.height * 0.01,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const ForgotPasswordPage())
                );},
                child: Text('ลืมรหัสผ่านใช่หรือไม่', style: TextStyle(color: secoundary, decoration: TextDecoration.underline),)
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            Center(
              child: DisableToggleButton(
                text: "เข้าสู่ระบบ", 
                minimumSize: Size(339, 36), 
                press: (){}
              ),
            ),
            SizedBox(height: size.height * 0.01,),
            Center(child: NoAccountRegister())
        ],
      ),
    );
  }

  void _togglePasswordView() {  
    setState(() {
      isHiddenPassword =! isHiddenPassword;  
    });
  }

}