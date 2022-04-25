import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/constants/translations.dart';
import 'package:flutter_application_1/screens/jassy_home/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'screens/landing/landing_page.dart';
import 'theme/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

//use this
class App extends StatelessWidget {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      // future: Firebase.initializeApp(),
      future: _calculation,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Text('error'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            navigatorKey: Get.key,
            navigatorObservers: [GetObserver()],
            debugShowCheckedModeBanner: false,
            translations: LocaleString(),
            locale: const Locale('th', 'TH'),
            onGenerateRoute: RouteGenerator.generateRoute,
            title: 'Jassy-Languages-Community',
            theme: ThemeData(
                textTheme: GoogleFonts.kanitTextTheme(),
                primaryColor: primaryColor,
                scaffoldBackgroundColor: greyLightest),
            home: const AuthGate(),
          );
        }
        // TODO: loading
        return const Center(
          child: CircularProgressIndicator(),
        ); // l
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  // void updateUserConnected(user, connected) async {
  //   CollectionReference users = FirebaseFirestore.instance.collection('Users');

  //   await users.doc(user!.uid).update({
  //     'isActive': connected,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LandingPage();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          return const JassyHome();
        }
        return const LandingPage();
      },
    );
  }
}
