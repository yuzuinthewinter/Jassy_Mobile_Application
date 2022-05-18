import 'package:basic_utils/basic_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/controllers/filter.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/detail_page.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:get/get.dart';

class JassyMainBody extends StatefulWidget {
  const JassyMainBody({Key? key}) : super(key: key);

  @override
  State<JassyMainBody> createState() => _JassyMainBodyState();
}

class _JassyMainBodyState extends State<JassyMainBody> {
  late PageController _pageController;
  int _currentPage = 0;

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Filtering filter = Filtering();
  FilterController filterController = Get.put(FilterController());
  late var _languageIndex;
  late var _languageLevelIndex;
  late var _genderIndex;
  late RangeValues _currentRangeValues;

  final _LanguageChoicesLists = ['Thai', 'Korean', 'Indonesian'];
  final List<String> _LanguageLevelChoicesLists = [
    "Beginner",
    "Elementary",
    "Intermidiate",
    "Upper Intermidiate",
    "Advanced",
    "Proficiency"
  ];
  final List<String> _GenderChoicesLists = [
    "InfoMale".tr,
    "InfoFemale".tr,
    "LGBTQ+",
    "FilterNoneGender".tr
  ];

  @override
  void initState() {
    filterController.fetchFilter();
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);

    _languageIndex = filterController.languageIndex.toInt();
    _languageLevelIndex = filterController.languageLevelIndex.toInt();
    _genderIndex = filterController.genderIndex.toInt();
    _currentRangeValues = filterController.currentRangeValues.value;

    filter.language = _LanguageChoicesLists[_languageIndex];
    filter.languageLevel = _LanguageLevelChoicesLists[_languageLevelIndex];
    filter.gender = _GenderChoicesLists[_genderIndex];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  likeUser(userid) async {
    await users.doc(currentUser!.uid).update({
      'liked': FieldValue.arrayUnion([userid]), //current user like ใคร
    });
    await users.doc(userid).update({
      'likesby':
          FieldValue.arrayUnion([currentUser!.uid]), //like โดย current user
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        StreamBuilder<QuerySnapshot>(
          stream:
              users.where('uid', isNotEqualTo: currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var users = snapshot.data!.docs;
            List queryUser = [];
            int indexLanguage = 0;
            for (var user in users) {
              int age =
                  calculateAge(DateTime.parse(user['birthDate'].toString()));
              _LanguageLevelChoicesLists.forEachIndexed((index, lvlang) {
                if ('${user['language']['levelDefaultLanguage']}'
                        .toLowerCase() ==
                    _LanguageLevelChoicesLists[index].toLowerCase()) {
                  indexLanguage = index;
                }
              });
              if (filter.language.toLowerCase() ==
                  user['language']['defaultLanguage'].toLowerCase()) {
                if (_languageLevelIndex <= indexLanguage) {
                  if (_currentRangeValues.start.round().toInt() <= age &&
                      age <= _currentRangeValues.end.round().toInt()) {
                    if (filter.gender.toLowerCase() ==
                        user['gender'].toLowerCase()) {
                      queryUser.add(user);
                    } else if (filter.gender.toLowerCase() ==
                        "FilterNoneGender".tr.toLowerCase()) {
                      queryUser.add(user);
                    }
                  }
                }
              }
            }
            return CarouselSlider.builder(
              itemCount: queryUser.length,
              itemBuilder: (context, index, child) {
                return carouselCard(queryUser[index]);
              },
              options: CarouselOptions(
                  // height: size.height * 0.70,
                  aspectRatio: 0.75,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enableInfiniteScroll: false),
            );
          },
        ),
      ],
    );
  }

  Widget carouselView(users, int index) {
    return carouselCard(users[index]);
  }

  // Widget carouselCard(MainUser data) {
  Widget carouselCard(user) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Interval(0, 0.5),
          );
          return FadeTransition(
            opacity: curvedAnimation,
            child:
                DetailPage(user: user, isMainPage: true, animation: animation),
          );
        }));
      }),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Hero(
              tag: user['profilePic'],
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: !user['profilePic'].isEmpty
                            ? NetworkImage(user['profilePic'][0])
                            : const AssetImage("assets/images/user3.jpg")
                                as ImageProvider,
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                            "assets/icons/close_circle.svg")))),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: size.height * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "kanit",
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(text: user['country']),
                                    // const TextSpan(text: ", "),
                                    // TextSpan(text: data.city),
                                    // const TextSpan(text: " "),
                                    // TextSpan(text: data.time)
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontFamily: "kanit",
                                      fontWeight: FontWeight.w900),
                                  children: [
                                    TextSpan(
                                        text: StringUtils.capitalize(
                                            user['name']['firstname'])),
                                    const TextSpan(text: ", "),
                                    TextSpan(
                                        text: calculateAge(DateTime.parse(
                                                user['birthDate'].toString()))
                                            .toString()),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "kanit",
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                        text: user['language']
                                            ['defaultLanguage']),
                                    const WidgetSpan(
                                        child: Icon(
                                      Icons.sync_alt,
                                      size: 20,
                                      color: textLight,
                                    )),
                                    TextSpan(
                                        text: user['language']
                                            ['interestedLanguage']),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                            onTap: () {
                              likeUser(user['uid']);
                            },
                            child: Expanded(
                                child: SvgPicture.asset(
                                    "assets/icons/heart_button.svg"))),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
