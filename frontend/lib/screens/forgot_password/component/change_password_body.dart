import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/alert/confirm_alert.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style1.dart';
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
  

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
   
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  User user = User();
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegExp regex = RegExp("(?=.*[A-Z])(?=.*[a-z])(?=.*?[!@#\$&*~.]).{8,}");


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CurvedWidget(
              child: HeaderStyle1()
            ),
            const HeaderText(text: "การเปลี่ยนรหัสผ่าน"),
            const DescriptionText(text: "กรุณากำหนดรหัสที่แข็งแรงและปลอดภัยเพื่อปกป้องบัญชีของคุณ"),
            SizedBox(height: size.height * 0.03,),
            const RequiredTextFieldLabel(
                  textLabel: "รหัสผ่าน",
            ),
            SizedBox(height: size.height * 0.01,),
            Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(
                controller: passwordController,
                obscureText: isHiddenPassword, 
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: _togglePasswordView,
                    child: isHiddenPassword? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                  ),
                  fillColor: textLight,
                  hintText: "กรุณากรอก",
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
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
                  if (value == null || value.isEmpty){
                    return "enter some text";
                  } else if (!regex.hasMatch(value)) {
                    return "กรุณากรอกตามpattern";
                  } return null;
                },
                onSaved: (String? password) {
                  user.password = password!;
                },
              ),
            ),
            SizedBox(height: size.height * 0.01,),
            const RequiredTextFieldLabel(
                  textLabel: "ยืนยันรหัสผ่าน",
            ),
            SizedBox(height: size.height * 0.01,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: isHiddenConfirmPassword,   
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: _toggleConfirmPasswordView,
                      child: isHiddenConfirmPassword? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                      ),
                    fillColor: textLight,
                    hintText: "กรุณากรอก",
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
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
                    }else if (passwordController.text != confirmPasswordController.text){
                      return "รหัสไม่ตรงกัน";
                    }
                    return null;
                  },
                ),
              ),
            Center(       
              child: DisableToggleButton(
                  text: "ยืนยันการตั้งค่ารหัสผ่าน",
                  minimumSize: Size(279, 36),
                  press: () {
                  if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print("password: ${user.password}");
                        showDialog(
                          context: context, 
                          builder: (BuildContext context){
                            return ConfirmAlert();
                          }
                        );
                      }
                  },
              )
            )
          ],
        ),
    );
  }

  void _togglePasswordView() {  
    setState(() {
      isHiddenPassword =! isHiddenPassword;  
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword =! isHiddenConfirmPassword;
    });
  }

}