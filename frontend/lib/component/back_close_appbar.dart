import 'package:flutter/material.dart';
import '../theme/index.dart';

class BackAndCloseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  
  const BackAndCloseAppBar({
    Key? key, 
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text, style: TextStyle(color: textDark),),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: BackButton(
        color: primaryDarker,
      ),
      actions: [
        IconButton(
          onPressed: () {}, 
          icon: Icon(Icons.close), 
          color: primaryDarker,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}