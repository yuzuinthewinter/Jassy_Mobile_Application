import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/popup_page/successWithButton.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/main-app/chat/chat_screen.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/jassy_main.dart';
import 'package:flutter_application_1/screens/main-app/like/like_screen.dart';
import 'package:flutter_application_1/screens/main-app/profile/profile.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JassyHome extends StatefulWidget {
  const JassyHome({Key? key}) : super(key: key);

  @override
  State<JassyHome> createState() => _JassyHomeState();
}

class _JassyHomeState extends State<JassyHome> {
  
  bool isLoading = false;

  var currentUser = FirebaseAuth.instance.currentUser;

  int _currentIndex = 2;

  final screens = [
    
    const JassyMain(),
    const LikeScreen(),//likes page
    const Center(
      child: Text('community'),
    ),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return isLoading 
      ? const CircularProgressIndicator()
      : Scaffold(  
      extendBodyBehindAppBar: true,
      // floatingActionButton: Visibility(
      //   visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      //   child: FloatingActionButton(
      //     child: SvgPicture.asset('assets/icons/jassy_water.svg'),
      //     backgroundColor: greyLightest,
      //     onPressed: () {
      //       Navigator.push(
      //         context, 
      //         MaterialPageRoute(builder: (context) => const JassyMain())
      //       );
      //     },
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก',),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'ถูกใจ'),
                  BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/jassy_water.svg', height: 35,), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.forum_outlined), label: 'แชท'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'โพรไฟล์')
                ]),
          ),
        ),
      ),
    );
  }
}
