import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/community_activity_appbar.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/component/group_activity/component/group_activity_screen_body.dart';
import 'package:flutter_application_1/screens/main-app/community/component/group_activity/write_post.dart';
import 'package:flutter_application_1/theme/index.dart';

class GroupActivityScreen extends StatelessWidget {
  final GroupActivity groupActivity;
  const GroupActivityScreen({ Key? key, required this.groupActivity }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommunityActivityAppBar(groupActivity: groupActivity),
      body: GroupActivityScreenBody(groupActivity: groupActivity,),
      // Todo: if join group show if not join dont show
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const WritePost()));
        },
        child: Icon(Icons.mode_edit_rounded),
        backgroundColor: primaryColor,
      ),
    );
  }
}