import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class TextFeildContainer extends StatelessWidget {
  final Widget child;
  const TextFeildContainer({
    Key? key, 
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: textLight,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: child,
    );
  }
}