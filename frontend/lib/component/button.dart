//TODO: re-componant from button folder

import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';


class ButtonComponent extends StatelessWidget {
  final String text, buttonVariant, iconPosition, icon;
  final Size buttonSize;
  final Color buttonColor, textColor;
  final VoidCallback handlePress;
  final bool disable, iconDisabled;
  
  const ButtonComponent({
    Key? key, 
    required this.text, 
    required this.buttonSize,
    required this.handlePress,
    this.buttonVariant = 'primary',
    this.buttonColor = primaryColor,
    this.textColor = textLight,
    this.icon = '',
    this.disable = true,
    this.iconDisabled = false,
    this.iconPosition = 'left'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: buttonSize,
            padding: const EdgeInsets.symmetric(horizontal: 80 , vertical: 12),
            primary: buttonColor,
            onPrimary: textColor,
            textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w300, fontFamily: 'Kanit')
          ),
          onPressed: handlePress, 
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              // Text(
              //   data: '123',
              // ),
            ],
            
          )
        ),
      ),
    );
  }
}