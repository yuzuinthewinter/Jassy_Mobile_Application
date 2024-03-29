import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BackAndDeleteAppBar extends StatelessWidget implements PreferredSizeWidget {

  const BackAndDeleteAppBar({
    Key? key,
    required this.delete, 
    required this.color,
    required this.text,
  }) : super(key: key);

  final VoidCallback delete;
  final Color color;
  final text;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      title: Text(text, style: TextStyle(color: textDark),),
      toolbarHeight: size.height * 0.15,
      centerTitle: true,
      elevation: 0,
      backgroundColor: color,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        color: primaryDarker,
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          onPressed: delete,
          icon: SvgPicture.asset('assets/icons/del_bin.svg', width: size.width * 0.045,),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
