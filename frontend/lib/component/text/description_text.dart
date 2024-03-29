import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  final double fontsize;
  const DescriptionText({
    Key? key, 
    required this.text,
    this.fontsize = 14.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
        fontSize: fontsize, 
        fontWeight: FontWeight.w500,
        color: greyDark
        ),
      ),
    );
  }
}