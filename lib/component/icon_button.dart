import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/constants.dart';

class IconButtonComponent extends StatelessWidget {
  final String text;
  final Size minimumSize;
  final Color color, textColor;
  final VoidCallback press;
  final SvgPicture iconPicture;
   
  const IconButtonComponent({
    Key? key, 
    required this.text, 
    required this.minimumSize, 
    this.color = primaryColor, 
    this.textColor = textLight, 
    required this.press, 
    required this.iconPicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: color,
            onPrimary: textColor,
            minimumSize: minimumSize,
            shape: const StadiumBorder(),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 50 , vertical: 12),
          ),
          onPressed: press, 
          icon: iconPicture, 
          label: Text(text),
      ),
    );
  }
}