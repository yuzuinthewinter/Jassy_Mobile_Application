import 'package:flutter/foundation.dart';

class Languages {
  //Landing Page
  final String LandingRegister;
  final String LandingHaveAccount;
  final String LandingLogin;
  final String LandingPreTermOfService;
  final String LandingTermOfService;
  final String LandingPrivacy;

  const Languages._({
    @required this.LandingRegister = '',
    @required this.LandingHaveAccount = '',
    @required this.LandingLogin = '',
    @required this.LandingPreTermOfService = '',
    @required this.LandingTermOfService = '',
    @required this.LandingPrivacy = '',
  });

  static const Languages th = Languages._(
    //Conjunction

    //Landing Page
    LandingRegister: 'ลงทะเบียนสำหรับผู้ใช้ใหม่',
    LandingHaveAccount: 'มีบัญชีผู้ใช้อยู่แล้ว ?',
    LandingLogin: 'เข้าสู่ระบบ',
    LandingPreTermOfService: 'หากคุณเข้าสู่ระบบคุณจะ',
    LandingTermOfService: 'ยอมรับข้อกำหนด',
    LandingPrivacy: 'นโยบายความเป็นส่วนตัวของเรา',
  );

  static const Languages en = Languages._(
    //Conjunction

    //Landing Page
    LandingRegister: 'Register',
    LandingHaveAccount: 'Already have an account?',
    LandingLogin: 'Log In',
    LandingPreTermOfService: 'By creating an account you agree to our',
    LandingTermOfService: 'Term of service',
    LandingPrivacy: 'Privacy',
  );

  static const List<Languages> values = [th, en];
}
