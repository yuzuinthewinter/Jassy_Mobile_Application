import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';

class CommunitySearch extends StatelessWidget {
  const CommunitySearch({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndCloseAppBar(text: "ค้นหากลุ่ม",),
    );
  }
}