import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
class EditChatListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget action;
  
  const EditChatListAppBar({
    Key? key,  
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("แก้ไขรายการสนทนา", style: TextStyle(color: textDark),),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        color: primaryDarker,
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        action
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}