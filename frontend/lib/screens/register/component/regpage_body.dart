import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/component/button/icon_button.dart';
import 'package:flutter_application_1/component/term_and_policies.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future _facebookLogin(BuildContext context) async {
    try {
      isLoading = true;
      final facebookLoginResult = await FacebookAuth.instance.login();
      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      Navigator.of(context).pushNamed(Routes.RegisterProfile);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      //TODO: failed
    }
  }

  Future _googleLogin(BuildContext context) async {
    late GoogleSignInAccount user;
    try {
      isLoading = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pushNamed(Routes.RegisterProfile);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? CircularProgressIndicator()
        : Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.1,
                ),
                SvgPicture.asset(
                  'assets/icons/landing_logo.svg',
                  height: size.height * 0.2,
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
                IconButtonComponent(
                  text: 'RegisterByPhone'.tr,
                  minimumSize: Size(279, 36),
                  iconPicture: SvgPicture.asset(
                    'assets/icons/mobile.svg',
                    height: 21,
                  ),
                  press: () {
                    Navigator.pushNamed(
                      context,
                      Routes.PhoneRegister,
                    );
                  },
                ),
                IconButtonComponent(
                  text: 'RegisterByFaceBook'.tr,
                  minimumSize: Size(279, 36),
                  iconPicture: SvgPicture.asset(
                    'assets/icons/facebook.svg',
                    height: 21,
                  ),
                  press: () => {_facebookLogin(context)},
                  color: facebookColor,
                ),
                IconButtonComponent(
                  text: 'RegisterByGoogle'.tr,
                  minimumSize: Size(279, 36),
                  iconPicture: SvgPicture.asset(
                    'assets/icons/google.svg',
                    height: 21,
                  ),
                  press: () {
                    _googleLogin(context);
                  },
                  color: textLight,
                  textColor: greyDarker,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                TermAndPolicies(),
              ],
            ),
          );
  }
}
