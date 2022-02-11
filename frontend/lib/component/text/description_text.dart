import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  const DescriptionText({
    Key? key, 
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
        fontSize: 16, 
        fontWeight: FontWeight.w500,
        color: greyDark
        ),
      ),
    );
  }
}