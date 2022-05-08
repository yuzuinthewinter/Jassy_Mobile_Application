import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

  Widget newsCard (News data, context) {
    var size = MediaQuery.of(context).size;
    return Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.02),
          width: size.width * 0.25,
          height: size.height * 0.25,
          decoration: BoxDecoration(
            color: textLight,
            border: Border(bottom: BorderSide(width: size.width * 0.01, color: primaryLightest))
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: const AssetImage("assets/images/user3.jpg"),
                radius: size.width * 0.08,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // group name
                      Text(data.groupName.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                      // post by
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: greyDark, fontSize: 14, fontFamily: 'kanit'),
                          children: [
                            TextSpan(text: "เขียนโดย "),
                            TextSpan(text: "Ammie "),
                            TextSpan(text: "เมื่อ "),
                            TextSpan(text: "10:24 AM "),
                          ]                      
                        ),
                      ),
                      // caption
                      SizedBox(height: size.height * 0.005),
                      Expanded(child: Text(data.news, style: TextStyle(fontSize: 18), maxLines: 3,)),
                      // like and comment
                      Row(
                        children: [
                          const LikeButtonWidget(),
                          SizedBox(width: size.width * 0.05),
                          SvgPicture.asset("assets/icons/comment_icon.svg", width: size.width * 0.07,)
                        ],
                      ),
                    ],
                  ),
                )
              ),
              Icon(Icons.more_horiz, color: primaryColor, size: size.width * 0.08,)
            ],
          ),
        );
  }