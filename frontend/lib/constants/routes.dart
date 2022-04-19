import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/popup_page/successWithButton.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/chat/chat_screen.dart';
import 'package:flutter_application_1/screens/jassy_home/home.dart';
import 'package:flutter_application_1/screens/landing/landing_page.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'package:flutter_application_1/screens/register/create_password.dart';
import 'package:flutter_application_1/screens/register/enter_otp.dart';
import 'package:flutter_application_1/screens/register/phone_register.dart';
import 'package:flutter_application_1/screens/register/register_page.dart';
import 'package:flutter_application_1/screens/register/register_info/language.dart';
import 'package:flutter_application_1/screens/register/register_info/profile.dart';

class Routes extends RouteGenerator {
  Routes._();

  //static const String  = '/';

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
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case Routes.PhoneRegister:
        return MaterialPageRoute(builder: (_) => PhoneRegister());
      case Routes.EnterOTP:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => EnterOTP(data));
      case Routes.CreatePassword:
        return MaterialPageRoute(builder: (_) => CreatePassword());

      //Register info
      case Routes.RegisterProfile:
        return MaterialPageRoute(builder: (_) => RegisterProfile());
      case Routes.RegisterLanguage:
        List<dynamic> data = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => RegisterLanguage(data[0], data[1]));

      case Routes.SuccessPage:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SuccessPage(data));

      //other
      case Routes.LoginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.LandingPage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case Routes.JassyHome:
        return MaterialPageRoute(builder: (_) => JassyHome());
      case Routes.ChatScreen:
        return MaterialPageRoute(builder: (_) => ChatScreen());
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