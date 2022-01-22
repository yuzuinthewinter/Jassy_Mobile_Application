import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.2,
                0.5,
                0.8,
              ],
              colors: [Color(0xFFE6E3FF), Color(0xFFFFEAEF), Color(0xFFFFEFE8)])
      ),
      width: double.infinity,
      child: child,
    );
  }
}