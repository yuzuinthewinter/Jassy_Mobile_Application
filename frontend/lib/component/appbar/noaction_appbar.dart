import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class NoActionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  
  const NoActionAppBar({
    Key? key, 
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 400,
      title: Text(text, style: TextStyle(color: textDark),),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}