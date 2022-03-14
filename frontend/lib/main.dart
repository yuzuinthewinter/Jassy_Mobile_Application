import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/landing/landing_page.dart';
import 'theme/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  //TODO: set languages for application
  // This widget is the root of your application.5
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          textTheme: GoogleFonts.kanitTextTheme(),
          primaryColor: primaryColor,
          scaffoldBackgroundColor: greyLightest),
      home: const LandingPage(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Text('error'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Auth',
            theme: ThemeData(
                textTheme: GoogleFonts.kanitTextTheme(),
                primaryColor: primaryColor,
                scaffoldBackgroundColor: greyLightest),
            home: const LandingPage(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
