import 'package:flutter/material.dart';

class HeaderStyle2 extends StatelessWidget {
  const HeaderStyle2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.3,
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
        image: DecorationImage(
          alignment: Alignment.bottomCenter, 
          image: AssetImage("assets/images/header_img2.png"),
        )
      ),
    );
  }
}