import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;

  Future _facebookLogin(BuildContext context) async {
    try {
      isLoading = true;
      final facebookLoginResult = await FacebookAuth.instance.login();

      final token = facebookLoginResult.accessToken!.token;
      final userId = facebookLoginResult.accessToken!.userId;
      print(userId);
      print(token);
      final facebookAuthCredential = FacebookAuthProvider.credential(token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v13.0/${userId}?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${token}'));
      final profile = json.decode(graphResponse.body);

      var currentUser = FirebaseAuth.instance.currentUser;
      var users = FirebaseFirestore.instance.collection('Users');
      var queryUser = users.where('uid', isEqualTo: currentUser!.uid);
      QuerySnapshot querySnapshot = await queryUser.get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      if (allData.isNotEmpty) {
        Navigator.of(context).pushNamed(Routes.JassyHome);
      } else {
        await users.doc(currentUser.uid).set({
          'name': {
            'firstname': '${profile['first_name']}',
            'lastname': '${profile['last_name']}',
          },
          'birthDate': '',
          'genre': '',
          'country': '',
          'language': {
            'defaultLanguage': '',
            'levelDefaultLanguage': '',
            'interestedLanguage': '',
            'levelInterestedLanguage': '',
          },
          'desc': '',
          'faceRegPic': const [],
          'profilePic': ['${profile['picture']['data']['url']}'],
          'chats': const [],
          'isActive': true,
        });
        Navigator.of(context).pushNamed(Routes.RegisterProfile);
      }
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
        ? const CircularProgressIndicator()
        : Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.15,
                ),
                SvgPicture.asset(
                  'assets/icons/landing_logo.svg',
                  height: size.height * 0.2,
                ),
                SizedBox(
                  height: size.height * 0.15,
                ),
                IconButtonComponent(
                  text: 'RegisterByPhone'.tr,
                  minimumSize: Size(size.width * 0.8, size.height * 0.05),
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
                  minimumSize: Size(size.width * 0.8, size.height * 0.05),
                  iconPicture: SvgPicture.asset(
                    'assets/icons/facebook.svg',
                    height: 21,
                  ),
                  press: () => {_facebookLogin(context)},
                  color: facebookColor,
                ),
                IconButtonComponent(
                  text: 'RegisterByGoogle'.tr,
                  minimumSize: Size(size.width * 0.8, size.height * 0.05),
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
                const TermAndPolicies(),
              ],
            ),
          );
  }
}
