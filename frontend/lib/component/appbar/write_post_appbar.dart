import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class WritePostAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPress;

  const WritePostAppBar({
    Key? key, required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      toolbarHeight: size.height * 0.15,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text("GroupPostHeader".tr, style: TextStyle(color: textDark),),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        color: primaryDarker,
        onPressed: () => {FocusScope.of(context).unfocus(), Navigator.of(context).pop()},
      ),
      actions: [
        TextButton(
          onPressed: onPress, 
          child: Text("Post", style: TextStyle(color: primaryDark, fontFamily: 'kanit', fontSize: 18),)
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
