import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/community_activity_appbar.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/group_activity_screen_body.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/write_post.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';

enum MenuItem { item1, item2 }

class GroupActivityScreen extends StatefulWidget {
  final groupActivity;
  final user;
  const GroupActivityScreen({Key? key, required this.user, required this.groupActivity}) : super(key: key);

  @override
  State<GroupActivityScreen> createState() => _GroupActivityScreenState();
}

class _GroupActivityScreenState extends State<GroupActivityScreen> {
  bool isNotificationOn = false;
  @override
  Widget build(BuildContext context) {
    bool isMember = false;
    for (var groupid in widget.user['groups']) {
      if (groupid == widget.groupActivity['groupid']) {
        isMember = true;
      }
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        toolbarHeight: size.height * 0.15,
        title: Column(
        children: [
          Text(
            widget.groupActivity['namegroup'],
            style: const TextStyle(fontSize: 18, color: textDark),
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
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
                TextSpan(text: widget.groupActivity['membersID'].length.toString())
              ]))
        ],
      ),
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
          PopupMenuButton<MenuItem>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onSelected: (value) => {
              if (value == MenuItem.item1)
                {
                  setState(() {
                    isNotificationOn = !isNotificationOn;
                  }),
                }
              else if (value == MenuItem.item2)
                {
                  // Todo: group leave
                }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: MenuItem.item1,
                  onTap: () {
                    // print(isNotificationOn);
                    // _toggleNotification;
                  },
                  child: Row(
                    children: [
                      isNotificationOn
                          ? SvgPicture.asset("assets/icons/notification_off.svg")
                          : SvgPicture.asset(
                              "assets/icons/notification_on.svg"),
                      SizedBox(width: size.width * 0.03,),
                      isNotificationOn
                          ? Text("MenuNotificationOff".tr)
                          : Text("MenuNotificationOn".tr),
                    ],
                  )),
              PopupMenuItem(
                  value: MenuItem.item2,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/leave_group.svg"),
                      SizedBox(width: size.width * 0.03,),
                      Text("GroupLeave".tr),
                    ],
                )),
            ],
            icon: const Icon(
              Icons.more_vert,
              color: primaryDarker,
            ),
          )
        ],
      ),

        body: GroupActivityScreenBody(
          user: widget.user,
          groupActivity: widget.groupActivity,
        ),
        // Todo: if join group show if not join dont show

        floatingActionButton: isMember == true
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WritePost(widget.user, widget.groupActivity)));
                },
                child: const Icon(Icons.mode_edit_rounded),
                backgroundColor: primaryColor,
              )
            : const SizedBox.shrink());
  }
}