import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/screens/main-app/profile/app_setting/component/app_setting_body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LandingPopup extends StatelessWidget {
  LandingPopup({Key? key}) : super(key: key);
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Background(
        child: Center(
          child: AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 100),
            onEnd: () => {_visible = true},
            // The green box must be a child of the AnimatedOpacity widget.
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                SvgPicture.asset(
                  'assets/icons/landing_logo.svg',
                  height: size.height * 0.2,
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
