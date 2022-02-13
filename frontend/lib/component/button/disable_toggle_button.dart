import 'package:flutter/material.dart';
import '../../theme/index.dart';

class DisableToggleButton extends StatefulWidget {
  final String text;
  final Size minimumSize;
  final Color color, textColor;
  final VoidCallback press;

  const DisableToggleButton({ 
    Key? key,
    required this.text, 
    required this.minimumSize, 
    this.color = primaryColor, 
    this.textColor = textLight, 
    required this.press,
    }) : super(key: key);

  @override
  _DisableToggleButtonState createState() => _DisableToggleButtonState();
}

class _DisableToggleButtonState extends State<DisableToggleButton> {

  @override
  Widget build(BuildContext context) {
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
            minimumSize: widget.minimumSize,
            padding: EdgeInsets.symmetric(horizontal: 80 , vertical: 12),
            primary: widget.color,
            onPrimary: widget.textColor,
            textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300, fontFamily: 'Kanit'),
            onSurface: grey,
          ),
          onPressed: widget.press,
          child: Text(widget.text)),
      ),
    );
  }
}