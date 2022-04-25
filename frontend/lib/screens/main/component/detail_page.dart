import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/main/component/desc_tabbar.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';

class DetailPage extends StatefulWidget {

  final MainUser user;
  final Animation animation;
  
  const DetailPage({ Key? key, required this.user, required this.animation }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  
  late TabController tabController;
  int currentTabIndex = 0;

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
      print(currentTabIndex);
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      onTabChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.addListener(() {
      onTabChange();
    });

    tabController.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).pop();
      }),
      child: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.user.image,
                child: Container(
                  width: size.width,
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(widget.user.image), fit: BoxFit.cover
                    )
                  ),
                ),
              ),
            ]
          ),
          Container(
            color: primaryColor,
            height: size.height * 0.5,
            child: Scaffold(
              body: Container(
                // padding: EdgeInsets.only(top: 20),
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(fontSize: 24, fontFamily: "kanit", color: textDark, fontWeight: FontWeight.w900),
                                  children: [TextSpan(text: widget.user.name), const TextSpan(text: ", "), TextSpan(text: widget.user.age)]
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(fontSize: 12, fontFamily: "kanit", color: greyDark, fontWeight: FontWeight.w700),
                                  children: [TextSpan(text: widget.user.country), const TextSpan(text: ", "), TextSpan(text: widget.user.city), const TextSpan(text: " "), TextSpan(text: widget.user.time)]
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                        padding: const EdgeInsets.only(right: 20, top: 5),
                        child: InkWell(
                          onTap: () { print("หัวใจ"); },
                          child: Expanded(child: SvgPicture.asset("assets/icons/heart_button.svg"))
                        ),
                      )
                      ]
                    ),
                    DescTabBar(tabController: tabController),
                    Container(
                      height: size.height * 0.25,
                      // color: greyDark,
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      // TODO widget.user.motherLanguage
                                      child: Text("Thai"),
                                    ),
                                    motherLanguageProgressBar(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      // TODO widget.user.interestLanguage
                                      child: Text("korean"),
                                    ),
                                    interestLanguageProgressBar(),
                                  ],
                                ),
                              ],
                            ),
                            // TODO widget.user.desc
                            Text("Descriptionnnnnnnn")
                          ]
                        ),
                      )
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
  
  Widget motherLanguageProgressBar()  {
    var size = MediaQuery.of(context).size;
    return IntervalProgressBar(
      direction: IntervalProgressDirection.horizontal,
      max: 6,
      progress: 6,
      intervalSize: 2,
      size: Size(size.width * 0.5, size.height * 0.015),
      highlightColor: primaryColor,
      defaultColor: grey,
      intervalColor: Colors.transparent,
      intervalHighlightColor: Colors.transparent,
      radius: 20
    );
  }

  Widget interestLanguageProgressBar()  {
    var size = MediaQuery.of(context).size;
    return IntervalProgressBar(
      direction: IntervalProgressDirection.horizontal,
      max: 6,
      progress: 3,
      intervalSize: 2,
      size: Size(size.width * 0.5, size.height * 0.015),
      highlightColor: secoundary,
      defaultColor: grey,
      intervalColor: Colors.transparent,
      intervalHighlightColor: Colors.transparent,
      radius: 20
    );
  }
  
}