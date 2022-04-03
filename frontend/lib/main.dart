import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/constants/translations.dart';
import 'package:flutter_application_1/screens/jassy_home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'screens/landing/landing_page.dart';
import 'theme/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

@deprecated // do not use this
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.5
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale('en', 'US'),
      title: 'Jassy-Languages-Community',
      theme: ThemeData(
          textTheme: GoogleFonts.kanitTextTheme(),
          primaryColor: primaryColor,
          scaffoldBackgroundColor: greyLightest),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: Routes.LandingPage,
      home: LandingPage(),
    );
  }
}

class App extends StatelessWidget {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      // future: Firebase.initializeApp(),
      future: _calculation,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Text('error'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            navigatorKey: Get.key,
            navigatorObservers: [GetObserver()],
            debugShowCheckedModeBanner: false,
            translations: LocaleString(),
            locale: Locale('th', 'TH'),
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: Routes.LandingPage,
            title: 'Jassy-Languages-Community',
            theme: ThemeData(
                textTheme: GoogleFonts.kanitTextTheme(),
                primaryColor: primaryColor,
                scaffoldBackgroundColor: greyLightest),
            home: LandingPage(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
