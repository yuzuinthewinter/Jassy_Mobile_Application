import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/component/post_detail_body.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';

enum MenuItem {
  item1,
  item2,
}

class PostDetail extends StatefulWidget {
  final postid;
  // ignore: prefer_const_constructors_in_immutables
  PostDetail({Key? key, required this.postid}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool isNotificationOn = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: size.height * 0.15,
        title: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Community')
                .where('postsID', arrayContains: widget.postid)
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text(''));
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text(''));
              }
              var group = snapshot.data!.docs[0];
              return Column(
                children: [
                  Text(
                    StringUtils.capitalize(group['namegroup']),
                    style: TextStyle(fontSize: 18, color: textDark),
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 14,
                              color: greyDark,
                              fontFamily: 'kanit'),
                          children: [
                        const WidgetSpan(
                            child: Icon(
                          Icons.person_rounded,
                          color: primaryColor,
                        )),
                        WidgetSpan(
                          child: SizedBox(
                            width: size.width * 0.01,
                          ),
                        ),
                        TextSpan(text: "${'GroupMember'.tr} "),
                        TextSpan(text: group['membersID'].length.toString())
                      ]))
                ],
              );
            }),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          color: primaryDarker,
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: [
        //   PopupMenuButton<MenuItem>(
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //     onSelected: (value) => {
        //       if (value == MenuItem.item1)
        //         {
        //           setState(() {
        //             isNotificationOn = !isNotificationOn;
        //           }),
        //         }
        //       else if (value == MenuItem.item2)
        //         {
        //           // Todo: group leave
        //         }
        //     },
        //     itemBuilder: (context) => [
        //       PopupMenuItem(
        //           value: MenuItem.item1,
        //           onTap: () {},
        //           child: Row(
        //             children: [
        //               isNotificationOn
        //                   ? SvgPicture.asset(
        //                       "assets/icons/notification_off.svg")
        //                   : SvgPicture.asset(
        //                       "assets/icons/notification_on.svg"),
        //               SizedBox(
        //                 width: size.width * 0.03,
        //               ),
        //               isNotificationOn
        //                   ? Text("MenuNotificationOff".tr)
        //                   : Text("MenuNotificationOn".tr),
        //             ],
        //           )),
        //       // PopupMenuItem(
        //       //     value: MenuItem.item2,
        //       //     child: Row(
        //       //       children: [
        //       //         SvgPicture.asset("assets/icons/leave_group.svg"),
        //       //         SizedBox(width: size.width * 0.03,),
        //       //         Text("GroupLeave".tr),
        //       //       ],
        //       //   )),
        //     ],
        //     icon: const Icon(
        //       Icons.more_vert,
        //       color: primaryDarker,
        //     ),
        //   )
        // ],
      ),
      body: PostDetailBody(postid: widget.postid),
     
    );
  }
}
