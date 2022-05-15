import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class BackOnlyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  
  const BackOnlyAppBar({
    Key? key, 
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text, style: TextStyle(color: textDark),),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20,),
        color: primaryDarker,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}