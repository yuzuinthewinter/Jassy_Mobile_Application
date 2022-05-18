import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class NoneAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;

  const NoneAppbar({
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
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
