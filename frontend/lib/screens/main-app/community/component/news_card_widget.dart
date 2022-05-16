import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

  Widget newsCard (News data, context) {
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
                        SizedBox(height: size.height * 0.007,),
                        // group name
                        Text(data.groupName.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
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
          // Todo: if has image show
          // SizedBox(height: size.height * 0.02,),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => FullScreenImage(context)),
          //     );
          //   },
            
          //   child: Container(
          //     constraints: BoxConstraints(maxHeight: size.height * 0.4, maxWidth: double.infinity),
          //     child: Hero(
          //       tag: 'post id',
          //       child: Image.asset("assets/images/user3.jpg", height: size.height * 0.4, width: double.infinity, fit: BoxFit.cover,)
          //     )
          //   ),
          // ),
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

Widget FullScreenImage (context) {
  return Scaffold(
      body: DismissiblePage(
        onDismissed: () {
          Navigator.of(context).pop();
        },
        direction: DismissiblePageDismissDirection.multi,
        child: Hero(
          tag: 'post id',
          child: Image.asset(
            "assets/images/chat_message.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.contain,
          ),
        ),
      )
    );
}