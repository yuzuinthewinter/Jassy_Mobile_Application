import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //Conjunction
          "ConAnd": "and",
          //Landing Page
          "LandingWelcome": "Let's start knowledge sharing !",
          "LandingRegister": "Register",
          "LandingHaveAccount": "Already have an account?",
          "LandingLogin": "Log In",
          "LandingPreTermOfService": "By creating an account you agree to our",
          "LandingTermOfService": "Term of service",
          "LandingPrivacy": "Privacy",
          //Register Page
          "RegisterByPhone": "Register with Phone Number",
          "RegisterByFaceBook": "Register with Facebook",
          "RegisterByGoogle": "Register with Google",
          //Phone Register Page
          "PhoneRegisterPage": "Register with phone number",
          "PhonePageFilled": "Enter your phone number",
          "PhonePageDesc":
              "Please enter your phone number for sending OTP to register.",
          "PhonePagePhoneNumber": "Phone number",
          //OTP comfirmed page
          "OtpPageFilled": "Enter OTP code",
          "OtpPageDesc":
              "Please enter the OTP you received via your phone number within the time limit.",
          "OtpTimeout": "This OTP will expire in 5 minutes.",
          "OtpResend": "Resend",
          //Phone Login Page
          "PhoneLoginPage": "Login with phone number",
          //Popup
          "RegisterSuccess": "Success",
          "NextButton": "Next",
          //Genre
          "Male" : "Male",
          "Female" : "Female",
          "LGBTQ+" : "LGBTQ+",
        },
        'th_TH': {
          // Conjunction
          "ConAnd": "และ",
          //Landing Page
          "LandingWelcome": "มาแลกเปลี่ยนความรู้กันเถอะ !",
          "LandingRegister": "ลงทะเบียนสำหรับผู้ใช้ใหม่",
          "LandingHaveAccount": "มีบัญชีผู้ใช้อยู่แล้ว ?",
          "LandingLogin": "เข้าสู่ระบบ",
          "LandingPreTermOfService": "หากคุณเข้าสู่ระบบคุณจะ",
          "LandingTermOfService": "ยอมรับข้อกำหนด",
          "LandingPrivacy": "นโยบายความเป็นส่วนตัวของเรา",
          //Register Page
          "RegisterByPhone": "ลงทะเบียนด้วยเบอร์โทรศัพท์",
          "RegisterByFaceBook": "ลงทะเบียนด้วย Facebook",
          "RegisterByGoogle": "ลงทะเบียนด้วย Google",
          //Phone Register Page
          "PhoneRegisterPage": "ลงทะเบียนด้วยเบอร์โทรศัพท์",
          "PhonePageFilled": "กรอกเบอร์โทรศัพท์",
          "PhonePageDesc":
              "กรุณากรอกหมายเลขโทรศัพท์ของคุณสำหรับการส่งเลข OTP เพื่อลงทะเบียน",
          "PhonePagePhoneNumber": "เบอร์โทรศัพท์",
          //OTP comfirmed page
          "OtpPageFilled": "กรุณาใส่รหัสลับ",
          "OtpPageDesc":
              "กรุณาใส่รหัส OTP ที่คุณได้รับผ่านหมายเลขโทรศัพท์ของคุณภายในเวลาที่กำหนด",
          "OtpTimeout": "รหัสนี้จะหมดเวลาภายใน 5 นาที",
          "OtpResend": " ส่งใหม่",
          //Phone Login Page
          "PhoneLoginPage": "เข้าสู่ระบบด้วยเบอร์โทรศัพท์",
          //Popup
          "RegisterSuccess": "ลงทะเบียนสำเร็จ",
          "NextButton": "ต่อไป",
          //Genre
          "Male" : "ชาย",
          "Female" : "หญิง",
          "LGBTQ+" : "LGBTQ+",
        },
      };
}
