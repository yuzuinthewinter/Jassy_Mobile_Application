import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/component/group_news_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupActivityScreenBody extends StatefulWidget {
  final GroupActivity groupActivity;

  const GroupActivityScreenBody({ 
    Key? key, 
    required this.groupActivity 
  }) : super(key: key);

  @override
  State<GroupActivityScreenBody> createState() => _GroupActivityScreenBodyState();
}

class _GroupActivityScreenBodyState extends State<GroupActivityScreenBody> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CurvedWidget(child: JassyGradientColor(gradientHeight: size.height * 0.23,)),
        // Todo: if now join show button if not join dont show button
        Center(
          child: RoundButton(
            text: "เข้าร่วมกลุ่ม", 
            minimumSize: Size(size.width * 0.8, size.height * 0.05), 
            press: () {}
          ),
        ),
        SizedBox(height: size.height * 0.01,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: textDark, fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'kanit'),
              children: [
                WidgetSpan(child: SvgPicture.asset("assets/icons/group_activity.svg")),
                WidgetSpan(child: SizedBox(width: size.width * 0.01,),),
                const TextSpan(text: "กิจกรรมของกลุ่ม")
              ]
            )
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: size.height * 0.02),
            scrollDirection: Axis.vertical,
            itemCount: newsLists.length,
            separatorBuilder: (BuildContext context, int index) { return SizedBox(height: size.height * 0.03,); },
            itemBuilder: (context, index) {
              // list of news card in group
              return groupNewsCard(newsLists[index], context);
            }
          ),
        ),
      ],
    );
  }
}