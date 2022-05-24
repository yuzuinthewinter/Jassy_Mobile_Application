import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/community_activity_appbar.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/member_group.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/group_activity_screen_body.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/write_post.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';

enum MenuItem { item1 }

enum AdminMenuItem { item1 }

class GroupActivityScreen extends StatefulWidget {
  final groupActivity;
  final user;
  const GroupActivityScreen(
      {Key? key, required this.user, required this.groupActivity})
      : super(key: key);

  @override
  State<GroupActivityScreen> createState() => _GroupActivityScreenState();
}

class _GroupActivityScreenState extends State<GroupActivityScreen> {
  bool isNotificationOn = false;

  CollectionReference groups =
      FirebaseFirestore.instance.collection('Community');
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  leaveGroup() async {
    await groups.doc(widget.groupActivity['groupid']).update({
      'membersID': FieldValue.arrayRemove([widget.user['uid']]),
    });
    await users.doc(widget.user['uid']).update({
      'groups': FieldValue.arrayRemove([widget.groupActivity['groupid']]),
    });
  }

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
                    TextSpan(
                        text:
                            widget.groupActivity['membersID'].length.toString())
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
            isMember
                ? PopupMenuButton<MenuItem>(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onSelected: (value) => {
                      if (value == MenuItem.item1)
                        {
                          widget.user['userStatus'] == 'admin'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MemberGroup(widget.groupActivity)))
                                : showDialog(
                                    context: context,
                                    builder: (context) {
                                  return WarningPopUpWithButton(
                                      text: 'WarningLeave'.tr,
                                      okPress: () {
                                      Navigator.of(context).pop();
                                     leaveGroup();
                                },
                             );
                          })
                        }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: MenuItem.item1,
                          child: Row(
                            children: [
                              widget.user['userStatus'] == 'admin'
                                  ? const Icon(
                                      Icons.person_rounded,
                                      color: primaryColor,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/leave_group.svg"),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              widget.user['userStatus'] == 'admin'
                                  ? Text('สมาชิก')
                                  : Text("GroupLeave".tr),
                            ],
                          )),
                    ],
                    icon: const Icon(
                      Icons.more_vert,
                      color: primaryDarker,
                    ),
                  )
                : widget.user['userStatus'] == 'admin'
                    ? const SizedBox
                        .shrink() //todo: to see member groups -> MemberGroup(widget.groupActivity)
                    : const SizedBox.shrink()
          ],
        ),
        body: GroupActivityScreenBody(
          user: widget.user,
          groupActivity: widget.groupActivity,
        ),
        floatingActionButton: widget.user['userStatus'] == 'admin'
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
            : isMember == true
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WritePost(
                                  widget.user, widget.groupActivity)));
                    },
                    child: const Icon(Icons.mode_edit_rounded),
                    backgroundColor: primaryColor,
                  )
                : const SizedBox.shrink());
  }
}
