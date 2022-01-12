import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class OutlinedButtonComponent extends StatelessWidget {
  final String text;
  final Size minimumSize;
  final Color color, textColor;
  final VoidCallback press;
  
  const OutlinedButtonComponent({
    Key? key, 
    required this.text, 
    required this.minimumSize, 
    this.color = primaryColor,
    this.textColor = primaryColor,  
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: minimumSize,
        padding: EdgeInsets.symmetric(horizontal: 50 , vertical: 12),
        primary: textColor,
        side: BorderSide(width: 2, color: color),
        shape: StadiumBorder(),
        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300, fontFamily: 'Kanit')
      ),
      onPressed: press, 
      child: Text(text));
  }
}