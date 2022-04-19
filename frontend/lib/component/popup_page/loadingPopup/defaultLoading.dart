import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:lottie/lottie.dart';

class defaultLoading extends StatefulWidget {
  @override
  _defaultLoading createState() => _defaultLoading();
}

class _defaultLoading extends State<defaultLoading> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: greyLightest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/loading.json',
            height: size.height * 0.2,
          )
        ],
      ),
    );
  }
}
