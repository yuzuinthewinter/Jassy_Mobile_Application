import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// news card in group
  Widget groupNewsCard (News data, context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        decoration: BoxDecoration(
          color: textLight,
          border: Border(bottom: BorderSide(width: size.width * 0.01, color: primaryLightest))
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.025,),
                        // post by
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: greyDark, fontSize: 14, fontFamily: 'kanit'),
                            children: [
                              TextSpan(text: "${'GroupPostBy'.tr} "),
                              TextSpan(text: "Ammie "),
                              TextSpan(text: "${'GroupPostAt'.tr} "),
                              TextSpan(text: "10:24 AM "),
                            ]                      
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                Icon(Icons.more_horiz, color: primaryColor, size: size.width * 0.08,)
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02,),
          // post text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              child: Text(data.news, maxLines: null, style: TextStyle(fontSize: 18),),
            ),
          ),
          SizedBox(height: size.height * 0.03,),
          // like and comment icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Row(
              children: [
                const LikeButtonWidget(),
                SizedBox(width: size.width * 0.05),
                InkWell(
                  onTap: () {
                    // FocusScope.of(context).requestFocus(myFocusNode);
                  },
                  child: SvgPicture.asset("assets/icons/comment_icon.svg", width: size.width * 0.07,)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }