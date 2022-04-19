import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20,),
        color: primaryDarker,
        onPressed: () => Navigator.of(context).pop(),
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
  Size get preferredSize => const Size.fromHeight(60.0);
}