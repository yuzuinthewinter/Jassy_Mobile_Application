import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/write_post_appbar.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/write_post_body.dart';

class WritePost extends StatelessWidget {
  final user;
  final group;
  const WritePost(this.user, this.group, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //todo : fix write post button and form in single page
      appBar: WritePostAppBar(),
      body: WritePostBody(user, group),
    );
  }
}
