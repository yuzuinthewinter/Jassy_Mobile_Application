import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/group_activity_screen.dart';
import 'package:flutter_application_1/theme/index.dart';

Widget groupForSearchWidget(group, context, user) {
  var size = MediaQuery.of(context).size;
  return InkWell(
    onTap: () {
      print("group");
      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        // NOTE: click and then go to each commumity group
        return GroupActivityScreen(
          user: user,
          groupActivity: group,
        );
      }));
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        width: double.infinity,
        height: size.height * 0.15,
        decoration: BoxDecoration(
            color: textLight,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.3),
                blurRadius: 3,
                offset: const Offset(0, 5),
              )
            ]),
        child: Row(
          children: [
            // Group Picture
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: size.width * 0.21,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(group['coverPic']), fit: BoxFit.cover),
                ),
              ),
            ),
            // Group Name + member count
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group['namegroup'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 14,
                                color: greyDark,
                                fontFamily: 'kanit'),
                            children: [
                          const WidgetSpan(
                              child: Icon(
                            Icons.person_rounded,
                            color: grey,
                          )),
                          WidgetSpan(
                            child: SizedBox(
                              width: size.width * 0.01,
                            ),
                          ),
                          TextSpan(
                            text: group['membersID'].length.toString(),
                            style: const TextStyle(fontSize: 16),
                          )
                        ]))
                  ],
                ),
              ),
            ),
            // add icon
            user['userStatus'] == 'user'
                ? InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.add_circle_rounded,
                      color: primaryColor,
                      size: size.width * 0.1,
                    ))
                : Container(
                    width: 1,
                  )
          ],
        ),
      ),
    ),
  );
}
