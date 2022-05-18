import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/filter.dart';
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
      title: Text(
        text,
        style: TextStyle(color: textDark),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Filter()));
          },
          icon: SvgPicture.asset(
            'assets/icons/filtering.svg',
          ),
          color: primaryDarker,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
