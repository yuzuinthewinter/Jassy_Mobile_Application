import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityScreenBody extends StatefulWidget {
  const CommunityScreenBody({ Key? key }) : super(key: key);

  @override
  State<CommunityScreenBody> createState() => _CommunityScreenBodyState();
}

class _CommunityScreenBodyState extends State<CommunityScreenBody> {
  @override
  Widget build(BuildContext context) {
    bool isHasNews = true;
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.01),
          child: Row(
            children: const [
              Text("แนะนำสำหรับคุณ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              Spacer(),
              Text("ดูเพิ่มเติม", style: TextStyle(fontSize: 16, color: primaryColor,)),
            ]
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.02),
          child: SizedBox(
            height: size.height * 0.1,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: communityLists.length,
              separatorBuilder: (BuildContext context, int index) { return SizedBox(width: size.width * 0.05,); },
              itemBuilder: (context, index) {
                return communityCard(communityLists[index]);
              },
            ),
          ),
        ),
        SizedBox(height: size.height * 0.03,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.01),
          child: Row(
            children: const [
              Text("ข่าวสาร", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              Spacer(),
              Text("กลุ่มของฉัน", style: TextStyle(fontSize: 16, color: primaryColor,)),
            ]
          ),
        ),
        // Todo: isEmpty show NoNewsWidget
        // NoNewsWidget(
        //   headText: "ยังไม่มีข่าวสารสำหรับคุณ",
        //   descText: "เริ่มเข้ากลุ่มเพื่อรับข่าวสารและแลกเปลี่ยนกันเถอะ !",
        //   size: size
        // )
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: size.height * 0.02),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: newsLists.length,
            separatorBuilder: (BuildContext context, int index) { return SizedBox(height: size.height * 0.03,); },
            itemBuilder: (context, index) {
              return newsCard(newsLists[index]);
            }
          ),
        )
      ],
    );
  }

  Widget communityCard (Community data) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width * 0.25,
          decoration: BoxDecoration(
            // color: primaryLight,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(data.image),
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
            data.name.toUpperCase(), 
            style: const TextStyle(fontSize: 16, color: textLight, fontFamily: 'kanit', fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          )
        )
      ],
    );
  }

  Widget newsCard (News data) {
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
                      const Text("THAI LANGUAGE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
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
                      const Expanded(child: Text("data", style: TextStyle(fontSize: 18), maxLines: 3,)),
                      // like and comment
                      Row(
                        children: [
                          const LikeButtonWidget(),
                          SizedBox(width: size.width * 0.05),
                          SvgPicture.asset("assets/icons/comment_icon.svg", width: size.width * 0.05,)
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

}