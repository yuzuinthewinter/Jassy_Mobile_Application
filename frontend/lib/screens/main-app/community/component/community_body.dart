import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/community_search/community_search.dart';
import 'package:flutter_application_1/screens/main-app/community/component/community_card.widget.dart';
import 'package:flutter_application_1/screens/main-app/community/component/news_card_widget.dart';
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
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.01),
          child: Row(
            children: [
              const Text("แนะนำสำหรับคุณ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              const Spacer(),
              InkWell(
                child: const Text("ดูเพิ่มเติม", style: TextStyle(fontSize: 16, color: primaryColor,)),
                onTap: () {
                  Navigator.push(context,
                    CupertinoPageRoute(builder: (context) {
                    return const CommunitySearch();
                  }));
                },
              ),
            ]
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.02),
          child: SizedBox(
            height: size.height * 0.1,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: groupLists.length,
              separatorBuilder: (BuildContext context, int index) { return SizedBox(width: size.width * 0.05,); },
              itemBuilder: (context, index) {
                return communityCard(groupLists[index], context);
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
              return newsCard(newsLists[index], context);
            }
          ),
        )
      ],
    );
  }

}