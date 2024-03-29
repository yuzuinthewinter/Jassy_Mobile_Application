import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class DescTabBar extends StatelessWidget {

  final TabController tabController;
  
  const DescTabBar({ Key? key, required this.tabController }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      height: size.height * 0.1,
      child: TabBar(
        controller: tabController,
        unselectedLabelColor: primaryColor,
        indicator: ShapeDecoration(
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        tabs: [
          Tab(
            icon: Text(
              'MainTabLanguage'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'kanit',
              ),
            ),
          ),
          Tab(
            icon: Text(
              'MainTabDesc'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'kanit',
              ),
            ),
          ),
        ],
      ),
    );
  }
}