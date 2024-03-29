// @dart=2.9
import 'package:camera/camera.dart';
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
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'theme/index.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  FlutterNativeSplash.removeAfter(initialization);
  // await Firebase.initializeApp();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    //  logError(e.code, e.description);
  }
  runApp(const App());
}

Future initialization(BuildContext context) async {
  await Firebase.initializeApp();
}

//use this
class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

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
        return Expanded(
          child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.3,
                      0.5,
                      0.8,
                    ],
                    colors: [
                      Color(0xFFE6E3FF),
                      Color(0xFFFFEAEF),
                      Color(0xFFFFEAC4)
                    ]),
              ),
              child: Lottie.asset(
                "assets/images/loading.json",
              )),
        ); // l
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  AuthGate({Key key}) : super(key: key);
  var currentUser = FirebaseAuth.instance.currentUser;

  checkUserAuth(context) async {
    var users = FirebaseFirestore.instance.collection('Users');
    var queryUser = users.where('uid', isEqualTo: currentUser.uid);
    var snapshot = await queryUser.get();

    if (snapshot.docs.isNotEmpty) {
      final data = await snapshot.docs[0];
      if (data['userStatus'] == 'admin') {
        Navigator.of(context).pushNamed(Routes.AdminJassyHome);
      } else if (data['userStatus'] == 'user') {
        if (data['isUser'] == true) {
          await users.doc(currentUser.uid).update({
            'isActive': true,
            'timeStamp': DateTime.now(),
          });
          if (data['isAuth'] == true) {
            Navigator.of(context).pushNamed(Routes.JassyHome,
                arguments: [4, true, false]); //isBlocked == false
          } else {
            return Navigator.of(context)
                .pushNamed(Routes.JassyHome, arguments: [4, false, true]);
          }
        } else {
          return Navigator.of(context).pushNamed(Routes.RegisterProfile);
        }
      } else if (data['userStatus'] == 'blocked') {
        return Navigator.of(context)
            .pushNamed(Routes.JassyHome, arguments: [4, true, true]);
      }
    } else {
      return Navigator.of(context).pushNamed(Routes.LandingPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LandingPage();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          checkUserAuth(context);
        }
        if (currentUser.uid == null) {
          return const LandingPage();
        }
        return Expanded(
          child: Container(
              color: greyLightest,
              child: Lottie.asset("assets/images/loading.json")),
        );
      },
    );
  }
}
