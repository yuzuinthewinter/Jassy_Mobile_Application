import 'package:flutter/material.dart';

class JassyGradientColor extends StatelessWidget {
  final double gradientHeight;
  const JassyGradientColor({
    Key? key, this.gradientHeight = 140,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: gradientHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [
          0.3,
          0.5,
          0.8,
        ],
        colors: [Color(0xFFE6E3FF), Color(0xFFFFEAEF), Color(0xFFFFEAC4)]),
      ),
    );
  }
}