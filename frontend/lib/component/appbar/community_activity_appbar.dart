import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class CommunityActivityAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CommunityActivityAppBar({
    Key? key,
    required this.groupActivity,
  }) : super(key: key);

  final groupActivity;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      toolbarHeight: size.height * 0.15,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Column(
        children: [
          Text(
            StringUtils.capitalize(groupActivity['namegroup']),
            style: TextStyle(fontSize: 18, color: textDark),
          ),
          RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 14, color: greyDark, fontFamily: 'kanit'),
                  children: [
                const WidgetSpan(
                    child: Icon(
                  Icons.person_rounded,
                  color: primaryColor,
                )),
                WidgetSpan(
                  child: SizedBox(
                    width: size.width * 0.01,
                  ),
                ),
                TextSpan(text: "${'GroupMember'.tr} "),
                TextSpan(text: groupActivity['membersID'].length.toString())
              ]))
        ],
      ),
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
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          color: primaryDarker,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
