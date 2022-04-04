import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JassyMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  
  const JassyMainAppBar({
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
      // leading: new IconButton(
      //   icon: Icon(Icons.arrow_back_ios, size: 20,),
      //   color: primaryDarker,
      //   onPressed: () => Navigator.of(context).pop(),
      // ),
      actions: [
        IconButton(
          onPressed: () {}, 
          icon: SvgPicture.asset('assets/icons/filtering.svg',), 
          color: primaryDarker,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}