import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoNewsWidget extends StatelessWidget {
  final String headText, descText;

  const NoNewsWidget({
    Key? key,
    required this.size,
    this.headText = '',
    this.descText = '',
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        SvgPicture.asset(
          "assets/images/no_news_image.svg",
          width: size.width * 0.55,
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          headText,
          style: TextStyle(fontSize: 18, color: textDark),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          descText,
          style: TextStyle(fontSize: 16, color: greyDark),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
