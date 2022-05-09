import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/component/community_search_body.dart';

class CommunitySearch extends StatelessWidget {
  final user;
  final groups;
  CommunitySearch(this.user, this.groups, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
        text: "ค้นหากลุ่ม",
      ),
      body: CommunitySearchBody(user, groups),
    );
  }
}
