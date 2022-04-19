import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';

class MessageScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final ChatUser user;
  
  const MessageScreenAppBar({
    Key? key, 
    this.text = '', 
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(user.name, style: TextStyle(fontSize: 18, color: textDark),),
          Text('3 mins ago', style: TextStyle(fontSize: 14, color: greyDark),),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: new IconButton(
        icon: Icon(Icons.arrow_back_ios, size: 20,),
        color: primaryDarker,
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          onPressed: () {}, 
          icon: Icon(Icons.phone), 
          color: primaryDarker,
        ),
        IconButton(
          onPressed: () {}, 
          icon: Icon(Icons.more_vert), 
          color: primaryDarker,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}