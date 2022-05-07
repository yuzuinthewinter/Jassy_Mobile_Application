import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/group_activity_screen.dart';
import 'package:flutter_application_1/theme/index.dart';

  Widget communityCard (GroupActivity data, context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print("group");
        Navigator.push(context,
          CupertinoPageRoute(builder: (context) {
            // NOTE: click each card to go to chat room
            return GroupActivityScreen(groupActivity: data,);
          })
        );
      },
      child: Stack(
        children: [
          Container(
            width: size.width * 0.25,
            decoration: BoxDecoration(
              // color: primaryLight,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(data.groupName.image),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            width: size.width * 0.25,
            decoration: BoxDecoration(
              color: textDark.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            width: size.width * 0.25,
            padding: EdgeInsets.symmetric(horizontal:  size.width * 0.02),
            alignment: Alignment.center,
            child: Text(
              data.groupName.name.toUpperCase(), 
              style: const TextStyle(fontSize: 16, color: textLight, fontFamily: 'kanit', fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            )
          )
        ],
      ),
    );
  }