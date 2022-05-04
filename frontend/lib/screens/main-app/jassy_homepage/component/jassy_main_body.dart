import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/calculate/cal_age.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/detail_page.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  likeUser(userid) {
    users.doc(currentUser!.uid).update({
      'liked': FieldValue.arrayUnion([userid]), //like โดย
    });
    users.doc(userid).update({
      'likesby': FieldValue.arrayUnion([currentUser!.uid]), //like โดย
    });
    removeUserafterLike();
  }

  removeUserafterLike() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('uid', isNotEqualTo: currentUser!.uid)
              .snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var user = snapshot.data!.docs;
            return CarouselSlider.builder(
              itemCount: user.length,
              itemBuilder: (context, index, child) {
                return carouselView(user, index);
              },
              options: CarouselOptions(
                // height: size.height * 0.70,
                aspectRatio: 0.75,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget carouselView(user, int index) {
    return carouselCard(user[index]);
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
            child: DetailPage(user: user, animation: animation),
          );
        }));
        print("each card");
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
                            : const AssetImage("assets/images/header_img1.png")
                                as ImageProvider,
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          
                        },
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
                                    TextSpan(text: user['name']['firstname']),
                                    const TextSpan(text: ", "),
                                    TextSpan(text: calculateAge(DateTime.parse(user['birthDate'].toString())).toString()),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "kanit",
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(text: user['language']['defaultLanguage']),
                                    const WidgetSpan(
                                        child: Icon(
                                      Icons.sync_alt,
                                      size: 20,
                                      color: textLight,
                                    )),
                                    TextSpan(text: user['language']['interestedLanguage']),
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
