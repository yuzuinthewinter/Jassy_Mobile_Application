import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/popup_page/successWithButton.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/admin/Admin/admin_screen.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/dash_screen.dart';
import 'package:flutter_application_1/screens/admin/Setting/setting_screen.dart';
import 'package:flutter_application_1/screens/admin/Users/user_screen.dart';
import 'package:flutter_application_1/screens/main-app/chat/chat_screen.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/jassy_main.dart';
import 'package:flutter_application_1/screens/main-app/like/like_screen.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminJassyHome extends StatefulWidget {
  const AdminJassyHome({Key? key}) : super(key: key);

  @override
  State<AdminJassyHome> createState() => _AdminJassyHomeState();
}

class _AdminJassyHomeState extends State<AdminJassyHome>
// with WidgetsBindingObserver
{
  //boolean
  bool isLoading = false;

  //firebasee
  final currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //set default navigator
  int _currentIndex = 0;
  final screens = [
    const DashboardScreen(),
    const UserScreen(),
    const AdminScreen(),
    SettingScreen(),
  ];

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
                          _currentIndex = index;
                        });
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.space_dashboard_rounded),
                          label: 'ข้อมูล',
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.people_alt), label: 'ผู้ใช้งาน'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.security), label: 'ผู้ดูแลระบบ'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.settings), label: 'ตั้งค่า')
                      ]),
                ),
              ),
            ),
          );
  }
}
