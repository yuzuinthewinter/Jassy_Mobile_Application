import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //Conjunction
          "ConAnd": "and",

          //Pre-Application
          //Landing Page
          "LandingWelcome": "Let's start knowledge sharing !",
          "LandingRegister": "Register",
          "LandingHaveAccount": "Already have an account ?",
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
          //Login Page
          "LoginPage": "Log In",
          "WelcomeLoginPage": "Welcome back!",
          "DescLoginPage": "Login to start exchanging languages.",
          "LoginWith": "or Login with",
          "PhoneLoginPage": "Phone number",
          "NoAccountLoginPage": "No account yet ?",

          //Register Info
          "InfoHeader": "Personal Information",
          "InfoDesc":
              "You can not change your age and gender after this, so please provide your real personal information.",
          "InfoFirstname": "Firstname",
          "InfoLastname": "Lastname",
          "InfoPleaseFill": "Please field information",
          "InfoDateBirth": "Date of Birth",
          "InfoSex": "Sex",
          "InfoMale": "Male",
          "InfoFemale": "Female",

          //Main-Application
          //Jassy Main Page
          "MainPage": "Home",

          //Jassy Like Page
          "LikePage": "Like",

          //Jassy Community Page
          "CommuPage": "",
          //Jassy Chat Page
          "ChatPage": "Chat",
          "HeaderChatPage": "Conversations",
          //Jassy Profile Page
          "ProfilePage": "Profile",

          //Profile Setting Page
          //Setting Page
          "AppSetting": "Setting",
          "ShowStatusSetting": "Status",
          "NotificationSetting": "Notification",
          "LanguageSetting": "Language",
          //Popup
          "RegisterSuccess": "Success",
          "NextButton": "Next",
        },
        'th_TH': {
          // Conjunction
          "ConAnd": "และ",

          //Pre-Application
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
          //Login Page
          "LoginPage": "เข้าสู่ระบบ",
          "WelcomeLoginPage": "ยินดีต้อนรับการกลับมา !",
          "DescLoginPage": "เข้าสู่ระบบเพื่อเริ่มต้นการแลกเปลี่ยนภาษาของคุณ",
          "LoginWith": "หรือเข้าสู่ระบบด้วย",
          "PhoneLoginPage": "เบอร์โทรศัพท์",
          "NoAccountLoginPage": "ยังไม่มีบัญชีผู้ใช้ ?",

          //Register Info
          "InfoHeader": "ข้อมูลส่วนตัว",
          "InfoDesc":
              "คุณไม่สามารถเปลี่ยนอายุและเพศหลังจากนี้ได้ดังนั้นโปรดให้ข้อมูลส่วนบุคคลที่แท้จริง",
          "InfoFirstname": "ชื่อ",
          "InfoLastname": "นามสกุล",
          "InfoPleaseFill": "กรุณากรอกข้อมูล",
          "InfoDateBirth": "วันเดือนปีเกิด",
          "InfoSex": "เพศ",
          "InfoMale": "ชาย",
          "InfoFemale": "หญิง",

          //Main-Application
          //Jassy Main Page
          "MainPage": "หน้าหลัก",
          //Jassy Like Page
          "LikePage": "ถูกใจ",
          //Jassy Community Page
          "CommuPage": "",
          //Jassy Chat Page
          "ChatPage": "แชท",
          "HeaderChatPage": "สนทนา",
          //Jassy Profile Page
          "ProfilePage": "โพรไฟล์",
          //Setting Page
          "AppSetting": "การตั้งค่า",
          "ShowStatusSetting": "การแสดงสถานะของคุณ",
          "NotificationSetting": "การแจ้งเตือน",
          "LanguageSetting": "ภาษา",
          //Popup
          "RegisterSuccess": "ลงทะเบียนสำเร็จ",
          "NextButton": "ต่อไป",
        },
      };
}
