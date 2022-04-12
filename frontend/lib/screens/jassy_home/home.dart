import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/buttom_appbar.dart';
import 'package:flutter_application_1/screens/chat/chat_screen.dart';
import 'package:flutter_application_1/screens/jassy_home/component/home_body.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JassyHome extends StatefulWidget {
  const JassyHome({ Key? key }) : super(key: key);

  @override
  State<JassyHome> createState() => _JassyHomeState();
}

class _JassyHomeState extends State<JassyHome> {


  int _currentIndex = 3;
  
  final screens = [
    Center(child: Text('home'),),
    Center(child: Text('likes'),),
    Center(child: Text('community'),),
    ChatScreen(),
    Center(child: Text('profile'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      extendBodyBehindAppBar: true,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton(
          child: SvgPicture.asset('assets/icons/jassy_water.svg'),
          backgroundColor: greyLightest,
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
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
                  BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.forum_outlined), label: 'แชท'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'โพรไฟล์')
                ]),
          ),
        ),
      ),
    );
  }
}