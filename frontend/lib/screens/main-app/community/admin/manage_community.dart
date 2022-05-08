import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/component/group_for_search_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManageCommunity extends StatefulWidget {
  final user;
  const ManageCommunity(this.user, {Key? key}) : super(key: key);

  @override
  State<ManageCommunity> createState() => _ManageCommunityState();
}

class _ManageCommunityState extends State<ManageCommunity> {
  late List<GroupActivity> grouplists;

  @override
  void initState() {
    super.initState();
    grouplists = groupLists;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: BackAndCloseAppBar(
          text: "การจัดการกลุ่ม",
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CurvedWidget(child: JassyGradientColor()),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.03,
                    horizontal: size.width * 0.05),
                child: Row(children: [
                  Text(
                    "กลุ่มทั้งหมด",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  InkWell(
                    child: const Text("แก้ไขกลุ่ม",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        )),
                    onTap: () {},
                  ),
                ])),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(
                    top: size.height * 0.01, bottom: size.height * 0.01),
                scrollDirection: Axis.vertical,
                itemCount: grouplists.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: size.height * 0.03,
                  );
                },
                itemBuilder: (context, index) {
                  final group = grouplists[index];
                  return groupForSearchWidget(group, context, widget.user);
                },
              ),
            ),
          ],
        ));
  }
}
