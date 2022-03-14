import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/landing/landing_page.dart';
import 'theme/index.dart';

void main() => runApp(const MyApp());
  
class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.5
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(),
        primaryColor: primaryColor,
        scaffoldBackgroundColor: greyLightest
      ),
      home: const LandingPage(),
    );
  }
}

