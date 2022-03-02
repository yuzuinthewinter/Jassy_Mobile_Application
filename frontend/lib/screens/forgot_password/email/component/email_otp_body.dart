import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style1.dart';
import 'package:flutter_application_1/component/numeric_numpad.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/register/create_password.dart';
import 'package:flutter_application_1/theme/index.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String code = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[     
        const CurvedWidget(
            child: HeaderStyle1(),
        ),
        InkWell(onTap: (){}, child: Text("clickkkkkk"),),
        const HeaderText(text: "กรุณาใส่รหัส OTP",),
        SizedBox(height: size.height * 0.01,),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          child: const Text(
            "เราจะส่งรหัสลับผ่าน email เพื่อให้คุณกำหนดรหัสผ่านใหม่",
            textAlign: TextAlign.left,
            style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.w500,
            color: greyDark
            ),
          ),
        ),  
        SizedBox(height: size.height * 0.02,),    
        Expanded(
              child: Container(
                width: double.infinity,
                height: 126,
                decoration: const BoxDecoration(
                  color: greyLightest,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildCodeNumberBox(code.length > 0 ? code.substring(0, 1) : ""),
                          buildCodeNumberBox(code.length > 1 ? code.substring(1, 2) : ""),
                          buildCodeNumberBox(code.length > 2 ? code.substring(2, 3) : ""),
                          buildCodeNumberBox(code.length > 3 ? code.substring(3, 4) : ""),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[              
                          const Text(
                            "รหัสนี้จะหมดเวลาภายใน 5 นาที",
                            style: TextStyle(
                              fontSize: 16,
                              color: secoundary,
                            ),
                          ),                          
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CreatePassword()),
                              );
                              print("ส่งใหม่");
                            },
                            child: const Text(
                              "ส่งใหม่",
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("ส่งใหม่");
                            },
                            child: const Icon(
                              Icons.replay,
                              color: primaryColor,
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            NumericPad(
                onNumberSelected: (value) {
                  print(value);
                  setState(() {
                    if(value != -1){
                      if(code.length < 4){
                        code = code + value.toString();
                      }
                    }
                    else{
                      code = code.substring(0, code.length - 1);
                    }
                    print(code);        
                  });
                },
              ),
      ],
    );
  }
}

Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: const BoxDecoration(
            color: textLight,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: greyLighter,
                  blurRadius: 30.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75)
              )
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit',
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }