import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/component/post_detail_body.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';

enum MenuItem { item1, item2 }
class PostDetail extends StatefulWidget {
  final News post;
  const PostDetail({Key? key, required this.post}) : super(key: key);

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
        title: Column(
        children: [
            Text(widget.post.groupName.name, style: TextStyle(fontSize: 18, color: textDark),),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: greyDark, fontFamily: 'kanit'),
                children: [
                  const WidgetSpan(child: Icon(Icons.person_rounded, color: primaryColor,)),
                  WidgetSpan(child: SizedBox(width: size.width * 0.01,),),
                  TextSpan(text: "${'GroupMember'.tr} "),
                  TextSpan(text: widget.post.groupName.member.toString())
                ]
              )
            )
          ],
        ),
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
        actions: [
          PopupMenuButton<MenuItem>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onSelected: (value) => {
              if (value == MenuItem.item1)
                {
                  setState(() {
                    isNotificationOn = !isNotificationOn;
                  }),
                }
              else if (value == MenuItem.item2)
                {
                  // Todo: group leave
                }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: MenuItem.item1,
                  onTap: () {
                    // print(isNotificationOn);
                    // _toggleNotification;
                  },
                  child: Row(
                    children: [
                      isNotificationOn
                          ? SvgPicture.asset("assets/icons/notification_on.svg")
                          : SvgPicture.asset(
                              "assets/icons/notification_off.svg"),
                      SizedBox(width: size.width * 0.03,),
                      isNotificationOn
                          ? Text("MenuNotificationOn".tr)
                          : Text("MenuNotificationOff".tr),
                    ],
                  )),
              PopupMenuItem(
                  value: MenuItem.item2,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/leave_group.svg"),
                      SizedBox(width: size.width * 0.03,),
                      Text("GroupLeave".tr),
                    ],
                )),
            ],
            icon: const Icon(
              Icons.more_vert,
              color: primaryDarker,
            ),
          )
        ],
      ),
      body: PostDetailBody(post: widget.post),
    );
  }
}