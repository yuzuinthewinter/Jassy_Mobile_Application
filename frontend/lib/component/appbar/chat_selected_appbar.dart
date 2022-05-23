import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatSelectedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget action;
  
  const ChatSelectedAppBar({
    Key? key, 
    this.text = '', 
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text, style: TextStyle(color: textDark),),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        action
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}