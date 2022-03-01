import 'package:flutter/material.dart';
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

  final _formKey = GlobalKey<FormState>();
  Info info = Info();
  TextEditingController emailController = TextEditingController();
  RegExp regex = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");

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
            const HeaderText(text: "การกู้รหัสผ่าน"),
            const DescriptionText(text: "เราจะส่งรหัสลับผ่าน email เพื่อให้คุณกำหนดรหัสผ่านใหม่"),
            SizedBox(height: size.height * 0.03),
            const RequiredTextFieldLabel(
                textLabel: "อีเมล",
              ),
              SizedBox(height: size.height * 0.01,),
              Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
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
                      return "enter valid email";
                    } return null;
                  },
                  onSaved: (String? email) {
                    info.email = email!;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.32),
              Center(
              child: DisableToggleButton(
                text: "ส่งลิงก์เพื่อกู้รหัสผ่าน", 
                minimumSize: const Size(339, 36),
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print("phone: ${info.email}");
                  //   Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const EnterOTP()),
                  // );
                  }
                },
              )
            )
          ],
        ),
    );
  }
}