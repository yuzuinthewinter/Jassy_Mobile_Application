import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

class Test extends StatelessWidget {
  final int color;
  const Test({ Key? key, required this.color }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
  
    return Container(
      height: 100,
      color: colors[color]
    );
  }
}