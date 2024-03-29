import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/controllers/filter.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_screen_body.dart';
import 'package:flutter_application_1/screens/main-app/community/community.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/jassy_main.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/pre_jassy_main.dart';
import 'package:flutter_application_1/screens/main-app/like/like_screen.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class JassyHome extends StatefulWidget {
  final indexpage;
  final isAuth;
  final isBlocked;
  JassyHome(this.indexpage, this.isAuth, this.isBlocked);

  @override
  State<JassyHome> createState() => _JassyHomeState();
}

class _JassyHomeState extends State<JassyHome> with WidgetsBindingObserver {
  //boolean
  bool isLoading = false;
  bool isBlocked = false;

  //firebasee
  final currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //set default navigator
  int _currentIndex = 2;
  List screens = [];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexpage;
    isBlocked = widget.isBlocked;
    WidgetsBinding.instance.addObserver(this);
    setStatus(true, DateTime.now());
    screens = [
      const JassyMain(),
      const LikeScreen(), //likes page
      const CommunityScreen(),
      const ChatScreenBody(),
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    setStatus(false, DateTime.now());
  }

  void setStatus(bool status, DateTime timestamp) async {
    await _firestore.collection('Users').doc(currentUser!.uid).update({
      'isActive': status,
      'timeStamp': timestamp,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    //is on screen
    if (state == AppLifecycleState.resumed) {
      if (currentUser != null) {
        setStatus(true, DateTime.now());
      } else {
        setStatus(false, DateTime.now());
      }
    } else {
      //is closed
      //is bg
      setStatus(false, DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            extendBodyBehindAppBar: true,
            body: screens[_currentIndex],
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8.0,
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: 70,
                child: Container(
                  child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      currentIndex: _currentIndex,
                      backgroundColor: greyLightest,
                      selectedItemColor: primaryColor,
                      onTap: (index) {
                        setState(() {
                          !isBlocked ? _currentIndex = index : _currentIndex;
                        });
                        if (isBlocked) {
                          if (widget.isAuth == false) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return WarningPopUpWithButton(
                                    text: 'WarningAuthUser'.tr,
                                    okPress: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(Routes.PhaseOneSuccess);
                                    },
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return WarningPopUpWithButton(
                                    text: 'WarningBlocked'.tr,
                                    okPress: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                });
                          }
                        }
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'MainPage'.tr,
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.favorite_border),
                            label: 'LikePage'.tr),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              'assets/icons/jassy_water.svg',
                              height: 35,
                            ),
                            label: 'CommuPage'.tr),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.forum_outlined),
                            label: 'ChatPage'.tr),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person), label: 'ProfilePage'.tr)
                      ]),
                ),
              ),
            ),
          );
  }
}
