import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/background.dart';
import 'package:flutter_application_1/component/popup_page/landingPopup.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/constants/translations.dart';
import 'package:flutter_application_1/screens/main-app/main.dart';
import 'package:flutter_application_1/screens/pre-app/landing/landing_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'theme/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

//use this
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppScreen();
}

class _AppScreen extends State<App> {
  final Future _calculation = Future.delayed(
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
            locale: const Locale('en', 'US'),
            onGenerateRoute: RouteGenerator.generateRoute,
            title: 'Jassy-Languages-Community',
            theme: ThemeData(
                textTheme: GoogleFonts.kanitTextTheme(),
                primaryColor: primaryColor,
                scaffoldBackgroundColor: greyLightest),
            home: AuthGate(),
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
  AuthGate({Key? key}) : super(key: key);
  var currentUser = FirebaseAuth.instance.currentUser;

  checkUserAuth(context) async {
    var users = FirebaseFirestore.instance.collection('Users');
    var queryUser = users.where('uid', isEqualTo: currentUser!.uid);
    var snapshot = await queryUser.get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs[0];
      if (data['userStatus'] == 'admin') {
        Navigator.of(context).pushNamed(Routes.AdminJassyHome);
      } else if (data['userStatus'] == 'user') {
        if (data['isAuth'] == true) {
          Navigator.of(context).pushNamed(Routes.JassyHome, arguments: 2);
        } else {
          //TODO: popup to user that register unfinish ** warning user
          return Navigator.of(context).pushNamed(Routes.RegisterProfile);
        }
      } else if (data['userStatus'] == 'blocked') {
        return Navigator.of(context).pushNamed(Routes.JassyHome, arguments: 4);
      }
    } else {
      return Navigator.of(context).pushNamed(Routes.LandingPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LandingPage();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          checkUserAuth(context);
        }
        if (currentUser!.uid == null) {
          return const LandingPage();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
