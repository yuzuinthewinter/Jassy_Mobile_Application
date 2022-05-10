import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/admin/manage_community.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/component/group_for_search_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommunitySearchBody extends StatefulWidget {
  final user;
  final groups;
  CommunitySearchBody(this.user, this.groups, {Key? key}) : super(key: key);

  @override
  State<CommunitySearchBody> createState() => _CommunitySearchBodyState();
}

class _CommunitySearchBodyState extends State<CommunitySearchBody> {
  TextEditingController searchController = TextEditingController();
  bool isSearchEmpty = true;
  String query = '';

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
    searchController.addListener(() {
      final isSearchEmpty = searchController.text.isNotEmpty;
      setState(() {
        this.isSearchEmpty = !isSearchEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                'assets/icons/search_input.svg',
                height: 16,
              ),
              hintText: 'CommuSearchInterest'.tr,
              filled: true,
              fillColor: textLight,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
            onChanged: searhGroup,
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.03, horizontal: size.width * 0.05),
            child: Row(children: [
              Text(
                isSearchEmpty
                    ? widget.user['userStatus'] == 'user'
                        ? "CommuRecommand".tr
                        : "กลุ่มทั้งหมด"
                    : "CommuResults".tr,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              // const Spacer(),
              // widget.user['userStatus'] == 'user'
              //     ? Container(
              //         width: 1,
              //       )
              //     : InkWell(
              //         child: const Text("การจัดการกลุ่ม",
              //             style: TextStyle(
              //               fontSize: 16,
              //               color: primaryColor,
              //             )),
              //         onTap: () {
              //           Navigator.push(context,
              //               CupertinoPageRoute(builder: (context) {
              //             return ManageCommunity(widget.user, widget.data);
              //           }));
              //         },
              //       )
            ])),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
                top: size.height * 0.01, bottom: size.height * 0.01),
            scrollDirection: Axis.vertical,
            itemCount: widget.groups.length,
            itemBuilder: (context, index) {
              final group = widget.groups[index];
              //todo: check user in group, will not show
              return Column(
                children: [
                  groupForSearchWidget(group, context, widget.user),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void searhGroup(String query) {
    // final suggestion = grouplists.where((group) {
    //   final groupName = group.groupName.name.toLowerCase();
    //   final searchInput = query.toLowerCase();

    //   return groupName.contains(searchInput);
    // }).toList();

    // setState(() => grouplists = suggestion);
  }
}
