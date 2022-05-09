import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/community_search.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/filter.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityAppBar extends StatefulWidget implements PreferredSizeWidget {
  final user;
  final group;
  final text;

  const CommunityAppBar({
    Key? key,
    this.user,
    this.group,
    this.text,
  }) : super(key: key);
  @override
  State<CommunityAppBar> createState() => _CommunityAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}

class _CommunityAppBarState extends State<CommunityAppBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      title: Text(
        widget.text,
        style: TextStyle(color: textDark),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: widget.user['userStatus'] == 'admin'
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              color: primaryDarker,
              onPressed: () => Navigator.of(context).pop(),
            )
          : Container(width: 1),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return CommunitySearch(widget.user, widget.group);
            }));
          },
          icon: SvgPicture.asset("assets/icons/search.svg"),
          color: primaryDarker,
        ),
        widget.user['userStatus'] == 'user'
            ? IconButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const Filter()));
                },
                icon: SvgPicture.asset("assets/icons/notification_icon.svg"),
                color: primaryDarker,
              )
            : Container(
                width: 1,
              ),
      ],
    );
  }
}
