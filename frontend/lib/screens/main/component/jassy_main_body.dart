import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JassyMainBody extends StatefulWidget {
  const JassyMainBody({ Key? key }) : super(key: key);

  @override
  State<JassyMainBody> createState() => _JassyMainBodyState();
}

class _JassyMainBodyState extends State<JassyMainBody> {

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CurvedWidget(
          child: JassyGradientColor()
        ),
        CarouselSlider.builder(
          itemCount: dataLists.length, 
          itemBuilder: (context, index, child) {
            return carouselView(index);
          }, 
          options: CarouselOptions(
            // height: size.height * 0.70,
            aspectRatio: 0.75,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          )
        ),
        // AspectRatio(
        //   aspectRatio: 0.75,
        //   child: PageView.builder(
        //     itemCount: dataLists.length,
        //     physics: const ClampingScrollPhysics(),
        //     controller: _pageController,
        //     itemBuilder: (context, index) {
        //       return carouselView(index);
        //     }
        //   ),
        // )
      ],
    );
  }

  Widget carouselView(int index) {
    return carouselCard(dataLists[index]);
  }

  Widget carouselCard(MainUser data) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(data.image), fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () { print("x"); },
              child: Align(
                alignment: Alignment.topRight, 
                child: SvgPicture.asset("assets/icons/close_circle.svg")
              )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: size.height * 0.15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))
                ),
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
                              style: const TextStyle(fontSize: 12, fontFamily: "kanit", fontWeight: FontWeight.w700),
                              children: [TextSpan(text: data.country), const TextSpan(text: ", "), TextSpan(text: data.city), const TextSpan(text: " "), TextSpan(text: data.time)]
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 24, fontFamily: "kanit", fontWeight: FontWeight.w900),
                              children: [TextSpan(text: data.name), const TextSpan(text: ", "), TextSpan(text: data.age)]
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 14, fontFamily: "kanit", fontWeight: FontWeight.w700),
                              children: [TextSpan(text: "TH"), WidgetSpan(child: Icon(Icons.sync_alt, size: 20, color: textLight,)), TextSpan(text: "KR"),]
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () { print("หัวใจ"); },
                        child: Expanded(child: SvgPicture.asset("assets/icons/heart_button.svg"))
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}