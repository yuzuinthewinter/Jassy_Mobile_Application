import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';

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
    return Container(
      child: Column(
        children: [
          const CurvedWidget(
            child: JassyGradientColor()
          ),
          AspectRatio(
            aspectRatio: 0.75,
            child: PageView.builder(
              itemCount: dataLists.length,
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) {
                return carouselView(index);
              }
            ),
          )
        ],
      ),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 24, fontFamily: "kanit"),
                        children: [TextSpan(text: data.name), const TextSpan(text: ", "), TextSpan(text: data.age)]
                      ),
                    ),
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