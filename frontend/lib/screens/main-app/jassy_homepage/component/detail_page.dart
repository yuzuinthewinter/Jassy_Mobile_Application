import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/desc_tabbar.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';

class DetailPage extends StatefulWidget {
  final user;
  final Animation animation;

  const DetailPage({Key? key, required this.user, required this.animation})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  final List _LanguageLevelChoicesLists = [
    "Beginner",
    "Elementary",
    "Intermidiate",
    "Upper Intermidiate",
    "Advance", //advanced
    "Proficiency"
  ];

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
      print(currentTabIndex);
    });
  }

  likeUser(userid) {
    users.doc(currentUser!.uid).update({
      'liked': FieldValue.arrayUnion([userid]), //like โดย
    });
    users.doc(userid).update({
      'likesby': FieldValue.arrayUnion([currentUser!.uid]), //like โดย
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
          Stack(children: [
            Hero(
              tag: widget.user['profilePic'],
              child: Container(
                width: size.width,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: !widget.user['profilePic'].isEmpty
                            ? NetworkImage(widget.user['profilePic'][0])
                            : const AssetImage("assets/images/header_img1.png")
                                as ImageProvider,
                        fit: BoxFit.cover)),
              ),
            ),
          ]),
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
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: "kanit",
                                        color: textDark,
                                        fontWeight: FontWeight.w900),
                                    children: [
                                      TextSpan(
                                          text: StringUtils.capitalize(widget
                                                  .user['name']['firstname']) +
                                              ' ' +
                                              StringUtils.capitalize(widget
                                                  .user['name']['lastname'])),
                                      const TextSpan(text: ", "),
                                      TextSpan(
                                          text: calculateAge(DateTime.parse(
                                                  widget.user['birthDate']
                                                      .toString()))
                                              .toString())
                                    ]),
                              ),
                              SizedBox(height: size.height * 0.01),
                              RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: "kanit",
                                        color: greyDark,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(text: widget.user['country']),
                                      // const TextSpan(text: ", "),
                                      // TextSpan(text: widget.user.city),
                                      // const TextSpan(text: " "),
                                      // TextSpan(text: widget.user.time)
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 5),
                          child: InkWell(
                              //todo: for like page
                              onTap: () {
                                likeUser(widget.user['uid']);
                              },
                              child: Expanded(
                                  child: SvgPicture.asset(
                                      "assets/icons/heart_button.svg"))),
                        )
                      ]),
                  DescTabBar(tabController: tabController),
                  Container(
                    height: size.height * 0.25,
                    // color: greyDark,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 10),
                    child: TabBarView(controller: tabController, children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                // TODO widget.user.motherLanguage
                                child: Text(
                                    widget.user['language']['defaultLanguage']),
                              ),
                              motherLanguageProgressBar(widget.user['language']
                                  ['levelDefaultLanguage']),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                // TODO widget.user.interestLanguage
                                child: Text(widget.user['language']
                                    ['interestedLanguage']),
                              ),
                              interestLanguageProgressBar(widget
                                  .user['language']['levelInterestedLanguage']),
                            ],
                          ),
                        ],
                      ),
                      // TODO widget.user.desc
                      Text(widget.user['desc'])
                    ]),
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget motherLanguageProgressBar(leveldefault) {
    var size = MediaQuery.of(context).size;
    int level = 0;
    _LanguageLevelChoicesLists.forEachIndexed((index, str) => {
          if (leveldefault.toLowerCase() ==
              _LanguageLevelChoicesLists[index].toLowerCase())
            {
              print(_LanguageLevelChoicesLists[index]),
              level = index + 1,
            }
        });

    return IntervalProgressBar(
        direction: IntervalProgressDirection.horizontal,
        max: 6,
        progress: level,
        intervalSize: 2,
        size: Size(size.width * 0.5, size.height * 0.015),
        highlightColor: primaryColor,
        defaultColor: grey,
        intervalColor: Colors.transparent,
        intervalHighlightColor: Colors.transparent,
        radius: 20);
  }

  Widget interestLanguageProgressBar(levelInt) {
    var size = MediaQuery.of(context).size;
    int level = 0;
    _LanguageLevelChoicesLists.forEachIndexed((index, str) => {
          if (levelInt.toLowerCase() ==
              _LanguageLevelChoicesLists[index].toLowerCase())
            {
              level = index + 1,
            }
        });
    return IntervalProgressBar(
        direction: IntervalProgressDirection.horizontal,
        max: 6,
        progress: level,
        intervalSize: 2,
        size: Size(size.width * 0.5, size.height * 0.015),
        highlightColor: secoundary,
        defaultColor: grey,
        intervalColor: Colors.transparent,
        intervalHighlightColor: Colors.transparent,
        radius: 20);
  }
}
