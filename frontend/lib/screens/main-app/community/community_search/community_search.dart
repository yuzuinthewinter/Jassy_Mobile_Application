import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/component/community_search_body.dart';

class CommunitySearch extends StatelessWidget {
  const CommunitySearch({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "ค้นหากลุ่ม",),
      body: CommunitySearchBody(),
    );
  }
}