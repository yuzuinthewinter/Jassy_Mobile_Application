import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class BottomAppbarMenu extends StatefulWidget {
  const BottomAppbarMenu({ Key? key }) : super(key: key);

  @override
  State<BottomAppbarMenu> createState() => _BottomAppbarMenuState();
}

class _BottomAppbarMenuState extends State<BottomAppbarMenu> {
  
  int _currentIndex = 1;
  final screens = [
    Center(child: Text('home'),),
    Center(child: Text('likes'),),
    Center(child: Text(''),),
    Center(child: Text('chat'),),
    Center(child: Text('profile'),),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 70,
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              // border: Border(
              //   top: BorderSide(
              //     color: Colors.grey,
              //     width: 0.5,
              //   ),
              // ),
            ),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                backgroundColor: greyLighter,
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
      );
  }
}