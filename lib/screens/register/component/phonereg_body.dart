import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style1.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/input_feilds/text_feild_container.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/register/enter_otp.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // late TextEditingController controller;

  // @override
  // void initState() {
  //   super.initState();

  //   controller = TextEditingController();
  //   controller.addListener(() {
      
  //   })
  // }

  // @override
  // void dispose() {
  //   controller.dispose();

  //   super.dispose();
  // }
  // bool isButtonActive = true;
  final _formKey = GlobalKey<FormState>();

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
          const HeaderText(text: "กรอกเบอร์โทรศัพท์",),
          SizedBox(height: size.height * 0.01,),
          const DescriptionText(
            text: "กรุณากรอกหมายเลขโทรศัพท์ของคุณสำหรับการส่งเลข OTP เพื่อลงทะเบียน",
          ),     
          SizedBox(height: size.height * 0.01,),
          const RequiredTextFieldLabel(
            textLabel: "เบอร์โทรศัพท์",
          ),
          SizedBox(height: size.height * 0.01,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(    
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(9)],
                decoration: InputDecoration(
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
                  }
                  return null;
                },
              ),
          ),
          SizedBox(height: size.height * 0.35,),
          Center(
            child: DisableToggleButton(
              text: "ตกลง", 
              minimumSize: const Size(279, 36),
              press: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EnterOTP()),
                );
                }
              },
            )
          )
        ],
      ),
    );
  }
}
