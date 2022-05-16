import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/none_appbar.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/filter_body.dart';
import 'package:get/get.dart';

class Filter extends StatelessWidget {
  const Filter({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: BackAndCloseAppBar(text: "FilterPage".tr),
            body: const FilterBody(),
            // body: DemoScreen(),
          );
  }
}
