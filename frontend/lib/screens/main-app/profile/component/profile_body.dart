import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/main-app/profile/about_jassy/about_jassy.dart';
import 'package:flutter_application_1/screens/main-app/profile/app_setting/app_setting.dart';
import 'package:flutter_application_1/screens/main-app/profile/help_center/help_center.dart';
import 'package:flutter_application_1/screens/main-app/profile/mark_as_like/mark_message_as_like.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile_setting/profile_setting.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/saved_post/saved_post.dart';
import 'package:flutter_application_1/screens/pre-app/register_info/picture_upload.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lottie/lottie.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBody();
}

class _ProfileScreenBody extends State<ProfileScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  void signOut() async {
    await users.doc(currentUser!.uid).update({
      'isActive': false,
      'timeStamp': DateTime.now(),
    });
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: currentUser!.uid)
          .snapshots(includeMetadataChanges: true),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset("assets/images/loading.json"),
          );
        }
        var user = snapshot.data!.docs[0];
        return Column(
          children: [
            ProfilePictureWidget(size: size, user: user),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              StringUtils.capitalize(user['name']['firstname']) +
                  ' ' +
                  StringUtils.capitalize(user['name']['lastname']),
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'kanit',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width * 0.13),
                      padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
                      width: size.width,
                      height: size.height * 0.20,
                      decoration: BoxDecoration(
                          color: textLight, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          ProfileMenu(
                            size: size,
                            icon: SvgPicture.asset("assets/icons/profile_icon.svg"),
                            text: "ProfileSetting".tr,
                            onTab: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return ProfileSetting(user: user);
                              }));
                            },
                          ),
                          ProfileMenu(
                            size: size,
                            icon: SvgPicture.asset("assets/icons/mark_as_like.svg"),
                            text: 'ProfileMarkAsLike'.tr,
                            onTab: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return MarkMessageAsLike(user);
                              }));
                            },
                          ),
                          ProfileMenu(
                            size: size,
                            icon: SvgPicture.asset("assets/icons/saved_lists.svg"),
                            // Todo: add translation
                            text: "ProfileSavedPost".tr,
                            onTab: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return SavedPost(user);
                              }));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width * 0.13),
                      padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
                      width: size.width,
                      height: size.height * 0.26,
                      decoration: BoxDecoration(
                          color: textLight, borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        ProfileMenu(
                          size: size,
                          icon: SvgPicture.asset("assets/icons/app_setting_icon.svg"),
                          text: 'ProfileAppSetting'.tr,
                          onTab: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return AppSetting(user);
                            }));
                          },
                        ),
                        ProfileMenu(
                            size: size,
                            icon: SvgPicture.asset("assets/icons/help_center_icon.svg"),
                            text: "ProfileHelp".tr,
                            onTab: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return HelpCenter(user);
                              }));
                            },
                        ),     
                        ProfileMenu(
                          size: size,
                          icon: SvgPicture.asset("assets/icons/about_jassy_icon.svg"),
                          text: "ProfileAboutJassy".tr,
                          onTab: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return PictureUpload();
                            }));
                          },
                        ),
                        Expanded(
                            child: InkWell(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/log_out_icon.svg"),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                "ProfileLogOut".tr,
                                style: TextStyle(color: textMadatory),
                              ),
                              Spacer(),
                              // Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                            ],
                          ),
                          onTap: () async {
                            signOut();
                            Navigator.pushNamed(context, Routes.LandingPage);
                          },
                        ))
                      ]),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
