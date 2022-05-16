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

import '../../component/community_card.widget.dart';

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
            onChanged: (String search) {
              search = searchController.text;
              query = search;
            },
          ),
        ),
        isSearchEmpty
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.height * 0.02),
                    child: Row(children: [
                      Text(
                        "CommuRecommand".tr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      )
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: SizedBox(
                      height: size.height * 0.1,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.groups.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: size.width * 0.05,
                          );
                        },
                        itemBuilder: (context, index) {
                          var group = widget.groups[index];
                          bool isMember = false;
                          for (var groupid in widget.user['groups']) {
                            if (groupid == group['groupid']) {
                              isMember = true;
                            }
                          }
                          return isMember == true
                              ? const SizedBox.shrink()
                              : communityCard(widget.user, group, context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.01),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.01),
                  child: Row(children: [
                    Text(
                      isSearchEmpty ? "CommuMyGroup".tr : "CommuResults".tr,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ]))
            ])),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Community')
                .where('namegroup',
                    isGreaterThanOrEqualTo: searchController.text.toLowerCase())
                .where('namegroup',
                    isLessThan: searchController.text.toLowerCase() + 'z')
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text(''),
                );
              }
              var data = snapshot.data!.docs;
              return ListView.builder(
                padding: EdgeInsets.only(
                    top: size.height * 0.01, bottom: size.height * 0.01),
                scrollDirection: Axis.vertical,
                itemCount: isSearchEmpty ? widget.groups.length : data.length,
                itemBuilder: (context, index) {
                  final group = widget.groups[index];
                  bool isMember = false;
                  for (var groupid in widget.user['groups']) {
                    if (groupid == group['groupid']) {
                      isMember = true;
                    }
                  }
                  return isSearchEmpty
                      ? isMember == true
                          ? Column(
                              children: [
                                groupForSearchWidget(
                                    group, context, widget.user),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                              ],
                            )
                          : const SizedBox.shrink()
                      : Column(
                          children: [
                            groupForSearchWidget(
                                data[index], context, widget.user),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                          ],
                        );
                },
              );
            },
          ),
        ),
        // Padding(
        //     padding: EdgeInsets.symmetric(
        //         vertical: size.height * 0.03, horizontal: size.width * 0.05),
        //     child: Row(children: [
        //       Text(
        //         isSearchEmpty ? "CommuRecommand".tr : "CommuResults".tr,
        //         style:
        //             const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        //       ),
        //     ])),
        // Expanded(
        //   child: ListView.builder(
        //     padding: EdgeInsets.only(
        //         top: size.height * 0.01, bottom: size.height * 0.01),
        //     scrollDirection: Axis.vertical,
        //     itemCount: widget.groups.length,
        //     itemBuilder: (context, index) {
        //       final group = widget.groups[index];
        //       bool isMember = false;
        //       for (var groupid in widget.user['groups']) {
        //         if (groupid == group['groupid']) {
        //           isMember = true;
        //         }
        //       }
        //       return isMember == true
        //           ? const SizedBox.shrink()
        //           : Column(
        //               children: [
        //                 groupForSearchWidget(group, context, widget.user),
        //                 SizedBox(
        //                   height: size.height * 0.03,
        //                 ),
        //               ],
        //             );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
