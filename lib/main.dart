import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/screens/landing/landing_page.dart';

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
        scaffoldBackgroundColor: bgColor
      ),
      home: const LandingPage(),
    );
  }
}

