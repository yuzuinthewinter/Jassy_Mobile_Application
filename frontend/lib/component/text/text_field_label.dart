import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class TextFieldLabel extends StatelessWidget {
  final String textLabel;
  const TextFieldLabel({
    Key? key, 
    required this.textLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        children: [
          Text(
            textLabel,
            style: const TextStyle(
              color: textDark,
              fontSize: 16, 
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}