import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class MarkMessageAsLikeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MarkMessageAsLikeAppBar({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      // toolbarHeight: size.height * 0.15,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "ProfileMarkAsLike".tr,
        style: TextStyle(color: textDark),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        color: primaryDarker,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
