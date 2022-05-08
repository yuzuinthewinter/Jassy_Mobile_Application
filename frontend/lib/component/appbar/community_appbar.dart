import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/community_search.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/filter.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CommunityAppBar({
    Key? key,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            Navigator.push(context,
              CupertinoPageRoute(builder: (context) {
              return const CommunitySearch();
            }));
          },
          icon: SvgPicture.asset("assets/icons/search.svg"),
          color: primaryDarker,
        ),
        IconButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const Filter()));
          },
          icon: SvgPicture.asset("assets/icons/notification_icon.svg"),
          color: primaryDarker,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
