import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/community_appbar.dart';
import 'package:flutter_application_1/screens/main-app/community/component/community_body.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommunityAppBar(text: "ชุมชน"),
      body: CommunityScreenBody(),
    );
  }
}