import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/popup_page/successWithButton.dart';
import 'package:flutter_application_1/screens/admin/main.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_screen_body.dart';
import 'package:flutter_application_1/screens/main-app/community/admin/manage_community.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/jassy_main.dart';
import 'package:flutter_application_1/screens/main-app/main.dart';
import 'package:flutter_application_1/screens/pre-app/landing/landing_page.dart';
import 'package:flutter_application_1/screens/pre-app/login/login.dart';
import 'package:flutter_application_1/screens/pre-app/register/create_password.dart';
import 'package:flutter_application_1/screens/pre-app/register/enter_otp.dart';
import 'package:flutter_application_1/screens/pre-app/register/phone_register.dart';
import 'package:flutter_application_1/screens/pre-app/register_info/component/phase_one_success.dart';
import 'package:flutter_application_1/screens/pre-app/register_info/language.dart';
import 'package:flutter_application_1/screens/pre-app/facereg/picture_upload.dart';
import 'package:flutter_application_1/screens/pre-app/register_info/profile.dart';
import 'package:flutter_application_1/screens/pre-app/register/register_page.dart';

class Routes extends RouteGenerator {
  Routes._();

  //Register
  static const String RegisterPage = '/RegisterPage';
  static const String PhoneRegister = '/PhoneRegister';
  static const String PhaseOneSuccess = '/PhaseOneSuccess';
  static const String PictureUpload = '/PictureUpload';
  static const String EnterOTP = '/EnterOTP';
  static const String CreatePassword = '/CreatePassword';

  //Register_info
  static const String RegisterProfile = '/RegisterProfile';
  static const String RegisterLanguage = '/RegisterLanguage';

  //Popup
  static const String SuccessPage = '/SuccessPage';
  //other
  static const String LoginPage = '/LoginPage';
  static const String LandingPage = '/LandingPage';
  static const String JassyHome = '/JassyHome';
  static const String JassyMain = '/JassyMain';
  static const String ChatScreen = '/ChatScreen';

  //Admin
  static const String AdminJassyHome = '/AdminJassyHome';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //case Routes. : return MaterialPageRoute(builder: (_) => ());
      //Register
      case Routes.RegisterPage:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case Routes.PhoneRegister:
        return MaterialPageRoute(builder: (_) => const PhoneRegister());
      case Routes.PhaseOneSuccess:
        return MaterialPageRoute(builder: (_) => const PhaseOneSuccess());
      case Routes.PictureUpload:
        return MaterialPageRoute(builder: (_) => const PictureUpload());
      case Routes.EnterOTP:
        List<String> data = settings.arguments as List<String>;
        return MaterialPageRoute(builder: (_) => EnterOTP(data[0], data[1]));
      case Routes.CreatePassword:
        return MaterialPageRoute(builder: (_) => const CreatePassword());

      //Register info
      case Routes.RegisterProfile:
        return MaterialPageRoute(builder: (_) => const RegisterProfile());
      case Routes.RegisterLanguage:
        List<dynamic> data = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => RegisterLanguage(data[0], data[1]));

      //popup
      case Routes.SuccessPage:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SuccessPage(data));

      //other
      case Routes.LoginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.LandingPage:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case Routes.JassyHome:
        List<dynamic> data = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => JassyHome(data[0], data[1], data[2]));
      case Routes.ChatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreenBody());

      case Routes.AdminJassyHome:
        var data = settings.arguments ?? 0;
        return MaterialPageRoute(builder: (_) => AdminJassyHome(data));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

// Navigator.pushNamed(context, '/Products', arguments: {"id": 1, "name": "apple"});