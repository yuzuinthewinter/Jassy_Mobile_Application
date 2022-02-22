import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Size minimumSize;
  final Color color, textColor;
  final VoidCallback? press;
  
  const RoundButton({
    Key? key, 
    required this.text, 
    required this.minimumSize,
    required this.press, 
    this.color = primaryColor, 
    this.textColor = textLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 3,
            offset: Offset(0, 5),
          )
        ]
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: minimumSize,
            padding: EdgeInsets.symmetric(horizontal: 80 , vertical: 12),
            primary: color,
            onPrimary: textColor,
            textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300, fontFamily: 'Kanit')
          ),
          onPressed: press, 
          child: Text(text)),
      ),
    );
  }
}