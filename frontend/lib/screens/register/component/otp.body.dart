import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style1.dart';
import 'package:flutter_application_1/component/numeric_numpad.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  final String phoneNumber;
  Body(this.phoneNumber);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationCode = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      timeout: Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(PhoneAuthCredential)
            .then((value) async {
          if (value.user != null) {
            Navigator.pushNamed(
              context,
              Routes.RegisterProfile,
            );
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) async {
        print(e.message);
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
    );
  }

  checkOTP(code) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode, smsCode: code))
          .then((value) async {
        if (value.user != null) {
          Navigator.pushNamed(
            context,
            Routes.RegisterProfile,
          );
        }
      });
    } catch (e) {
      // TODO: return invalid popup
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => super.widget),
      );
    }
  }

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
        HeaderText(
          text: 'OtpPageFilled'.tr,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          child: Text(
            'OtpPageDesc'.tr,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: greyDark),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: size.height * 0.03,
            decoration: const BoxDecoration(
              color: greyLightest,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildCodeNumberBox(
                          code.length > 0 ? code.substring(0, 1) : "", context),
                      buildCodeNumberBox(
                          code.length > 1 ? code.substring(1, 2) : "", context),
                      buildCodeNumberBox(
                          code.length > 2 ? code.substring(2, 3) : "", context),
                      buildCodeNumberBox(
                          code.length > 3 ? code.substring(3, 4) : "", context),
                      buildCodeNumberBox(
                          code.length > 4 ? code.substring(4, 5) : "", context),
                      buildCodeNumberBox(
                          code.length > 5 ? code.substring(5, 6) : "", context),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'OtpTimeout'.tr,
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
                            MaterialPageRoute(
                                builder: (context) => super.widget),
                          );
                          print("ส่งใหม่");
                        },
                        child: Text(
                          'OtpResend'.tr,
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
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        NumericPad(
          onNumberSelected: (value) {
            setState(() {
              if (value != -1) {
                if (code.length < 6) {
                  code = code + value.toString();
                  print(code.length);
                  if (code.length == 6) {
                    checkOTP(code);
                  }
                }
              } else {
                code = code.substring(0, code.length - 1);
              }
              // print(code);
            });
          },
        ),
      ],
    );
  }
}

Widget buildCodeNumberBox(String codeNumber, BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
    child: SizedBox(
      width: size.width * 0.12,
      height: size.height * 0.065,
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
                offset: Offset(0.0, 0.75))
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
