import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/popup_page/successWithButton.dart';
import 'package:flutter_application_1/screens/main-app/chat/chat_screen.dart';
import 'package:flutter_application_1/screens/main-app/main.dart';
import 'package:flutter_application_1/screens/pre-app/landing/landing_page.dart';
import 'package:flutter_application_1/screens/pre-app/login/login.dart';
import 'package:flutter_application_1/screens/pre-app/register/create_password.dart';
import 'package:flutter_application_1/screens/pre-app/register/enter_otp.dart';
import 'package:flutter_application_1/screens/pre-app/register/phone_register.dart';
import 'package:flutter_application_1/screens/pre-app/register_info/language.dart';
import 'package:flutter_application_1/screens/pre-app/register_info/profile.dart';
import 'package:flutter_application_1/screens/pre-app/register/register_page.dart';

class Routes extends RouteGenerator {
  Routes._();

  //Register
  static const String RegisterPage = '/RegisterPage';
  static const String PhoneRegister = '/PhoneRegister';
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
  static const String ChatScreen = '/ChatScreen';
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
        return MaterialPageRoute(builder: (_) => const JassyHome());
      case Routes.ChatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
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