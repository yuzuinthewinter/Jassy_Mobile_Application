import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final double fontsize;
  const HeaderText({
    Key? key, 
    required this.text,
    this.fontsize = 18.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
        fontSize: fontsize, 
        fontWeight: FontWeight.w500,
        color: textDark
        ),
      ),
    );
  }
}