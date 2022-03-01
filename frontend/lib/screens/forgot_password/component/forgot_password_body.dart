import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style1.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CurvedWidget(
            child: HeaderStyle1()
          ),
          const HeaderText(text: "ลืมรหัสผ่าน"),
          const DescriptionText(text: "กรุณาเลือกช่องทางการส่งลิงก์เพื่อกำหนดรหัสผ่านใหม่"),
          SizedBox(height: size.height * 0.03,),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 3,
                    offset: const Offset(0, 5),
                  )
                ]
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(275, 70),
                    padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 12),
                    primary: textLight,
                    onPrimary: textDark,
                    textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300, fontFamily: 'Kanit'),
                    alignment: Alignment.centerLeft
                  ),
                  
                  onPressed: () {}, 
                  icon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5 , vertical: 0),
                    child: SvgPicture.asset('assets/icons/email_circle.svg',)
                  ),
                  label: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: textDark,
                        fontFamily: 'Kanit',
                      ),
                      children: [
                        TextSpan(text: "กำหนดรหัสใหม่ด้วย email\n",),
                        TextSpan(text: "กรณีที่คุณสมัครด้วย Email", style: TextStyle(color: greyDark, fontSize: 12))
                      ]
                    )
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 3,
                    offset: const Offset(0, 5),
                  )
                ]
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(275, 70),
                    padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 12),
                    primary: textLight,
                    onPrimary: textDark,
                    textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w300, fontFamily: 'Kanit'),
                    alignment: Alignment.centerLeft
                  ),
                  
                  onPressed: () {}, 
                  icon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5 , vertical: 0),
                    child: SvgPicture.asset('assets/icons/phone_circle.svg',)
                  ),
                  label: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: textDark,
                        fontFamily: 'Kanit',
                      ),
                      children: [
                        TextSpan(text: "กำหนดรหัสใหม่ผ่าน SMS\n",),
                        TextSpan(text: "กรณีที่คุณสมัครด้วย เบอร์โทรศัพท์", style: TextStyle(color: greyDark, fontSize: 12))
                      ]
                    )
                  ),
                ),
              ),
            ),
          )
        ],
      );
  }
}