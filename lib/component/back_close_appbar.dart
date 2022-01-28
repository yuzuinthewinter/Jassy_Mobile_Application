import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class BackAndCloseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAndCloseAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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