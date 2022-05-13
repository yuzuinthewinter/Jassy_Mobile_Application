import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/community_activity_appbar.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/group_activity_screen_body.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/write_post.dart';
import 'package:flutter_application_1/theme/index.dart';

class GroupActivityScreen extends StatelessWidget {
  final groupActivity;
  final user;
  const GroupActivityScreen(
      {Key? key, required this.user, required this.groupActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMember = false;
    for (var groupid in user['groups']) {
      if (groupid == groupActivity['groupid']) {
        isMember = true;
      }
    }
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CommunityActivityAppBar(groupActivity: groupActivity),
        body: GroupActivityScreenBody(
          user: user,
          groupActivity: groupActivity,
        ),
        floatingActionButton: isMember == true
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WritePost(user, groupActivity)));
                },
                child: Icon(Icons.mode_edit_rounded),
                backgroundColor: primaryColor,
              )
            : const SizedBox.shrink());
  }
}
