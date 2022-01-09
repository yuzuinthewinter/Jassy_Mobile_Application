import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class TextLinkButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color textColor;
  
  const TextLinkButton({
    Key? key, 
    required this.text, 
    required this.press, 
    this.textColor = primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
      primary: textColor,
      textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300, fontFamily: 'Kanit')
    ),
      onPressed: press,
      child: Text(text),
      );
  }
}