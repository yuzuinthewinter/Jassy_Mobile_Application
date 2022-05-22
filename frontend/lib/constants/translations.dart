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
          //Language Info
          "InfoLangHeader": "Language Information",
          "InfoLangDesc":
              "You can not change your nationality and mother tongue after this, So please provide real personal information.",
          "InfoCountry": "Country",
          "InfoFirstLanguage": "First Language",
          "InfoLevelFirstLanguage": "Level of First Language",
          "InfoLanguageInterest": "Language Interest",
          "InfoLevelLanguageInterest": "Level of Language Interest",
          //Profile Picture Upload
          "ProfilePictureUpload": "Please upload your profile picture.",
          "ProfilePictureDesc":
              "Please upload a clear picture. Don't look back, obscene, involved in religious/political provocation and don't deceive money.",
          "ProfilePictureWarning":
              "The selected picture cannot be edited, please select the picture carefully.",
          "ProfilePictureUploadButton": "Upload Image",

          //Main-Application
          //Jassy Main Page
          "MainPage": "Home",
          "MainTabLanguage": "Level of Language",
          "MainTabDesc": "Description",
          "MainNoUserTitle":
              "There are no users who have matched\ntheir requirements to yours now.",
          "MainNoUserDesc": "Please select the closest requirement.",
          //Filter
          "FilterLang": "Language",
          "FilterLevelLang": "Level of Language",
          "FilterSex": "Sex",
          "FilterNoneGender": "None",
          "FilterAge": "Age",
          "FilterReset": "Reset",
          "FilterPage": "Filter",
          "FilterButton": "Filter",

          //Jassy Like Page
          "LikePage": "Like",
          "NoLikesTitle":
              "No one want to share their language\n with you at this time",
          "NoLikesDesc": "Let's start searching for the person you like.!",

          //Jassy Community Page
          "CommuPage": "Community",
          "CommuRecommand": "Recommend for you",
          "CommuMore": "See More",
          "CommuFeed": "News Feed",
          "CommuNoFeed": "There is no news for you yet.",
          "CommuStartJoin":
              "Let's start by joining the group\n to receive news and exchange!",
          "CommuMyGroup": "My Groups",
          "CommuSearch": "Search",
          "CommuSearchGroup": "Search",
          "CommuSearchInterest": "Find a Group of Interest",
          "CommuFindGroup": "Find a Group",
          "CommuResults": "Search Results",
          //Group Activity
          "GroupActivity": "Group Activities",
          "GroupJoin": "Join Group",
          "GroupMember": "Member",
          "GroupNotificationOff": "Turn off group notifications",
          "GroupNotificationOn": "Turn on group notifications",
          "GroupLeave": "Leave group",
          "GroupPostHeader": "Create Post",
          "GroupPostButton": "Post",
          "GroupPostHintText": "What's on your mind",
          "GroupPostAddPic": "Photo/Video",
          "GroupPostReport": "Report Post",
          "GroupPostDelete": "Delete Post",
          "GroupPostNotiOff": "Turn off notifications for this post",
          "GroupPostNotiOn": "Turn on notifications for this post",
          "GroupPostBy": "Posted by",
          "GroupPostAt": "at",
          "GroupPostToday": "Today",
          "GroupPostYesterday": "Yesterday",
          "GroupPostCommentHintText": "Write a comment",
          "GroupDeleteWarning": "Are you want to delete this post ?",

          //Jassy Chat Page
          "ChatPage": "Chat",
          "HeaderChatPage": "Conversations",
          "SearchChat": "Search",
          "ChatRead": "Read",
          "ChatHintText": "Enter a message",
          "ChatShowReport": "You can not message this account.",
          "NoChatPartner": "You don’t currently have a chat partner.",
          "FindChatPartner":
              "Let's start searching for a language exchange partner. !",
          //Appbar Chat
          "StatusActiveNow": "Active now",
          "StatusActiveAfew": "Active a few minutes ago",
          "StatusActive": "Active",
          "StatusActiveMins": "m ago",
          "StatusActiveHours": "h ago",
          "StatusActiveDays": "d ago",
          "MenuNotificationOn": "Turn on notifications",
          "MenuNotificationOff": "Turn off notifications",
          "MenuUnmatch": "Unmatch",
          "MenuReport": "Report",
          //unmatch
          "WarningUnmatch": "Are you sure you want to unmatch?",
          "WarningReport": "Are you sure you want to report this user?",
          "WarningReportPost": "Are you sure you want to report this post?",
          //Report
          "ReportDetail": "Report Details",
          "ReportWarning":
              "You will no longer be able to see this user. Are you sure to report?",
          "ReportFill": "Pleade Field",
          "ReportAttach": "Attach Evidence of The Report.",
          "ReportAddFile": "Add Image",
          "ReportChoose": "Please select an issue",
          "ReportDesc":
              "Before reporting the problem to Jassy.If you feel in danger, Please ask for help first.",
          "ReportNudity": "Nudity",
          "ReportVio": "Violence",
          "ReportThreat": "Threat",
          "ReportProfan": "Profanity",
          "ReportTerro": "Terrorism",
          "ReportChild": "Child Labor",
          "ReportSexual": "Sexual Exploitation",
          "ReportAnimal": "Animal Abuse",
          "ReportScam": "Scammer",
          "ReportAbuse": "Substance Abuse Support",
          "ReportOther": "Other",

          //Jassy Profile Page
          "ProfilePage": "Profile",
          "ProfileSetting": "Profile Settings",
          "ProfileHelp": "Help Center",
          "ProfileAppSetting": "Settings",
          "ProfileMarkAsLike": "Mark as Like",
          "ProfileSavedPost": "Saved Post ",
          "ProfileSavedPostBy": "Post from ",
          "ProfileSeeSavedPost": "See Original Post",
          "ProfileRemoveSavedPost": "Remove saved post",
          "ProfileAboutJassy": "About Jassy",
          "ProfileLogOut": "Log Out",

          //Profile Setting Page
          "ProfileDesc": "Description",
          "ProfileSaveChange": "Save Change",
          "ProfileTabInfo": "Personal Information",
          "ProfileTabLang": "Language",

          //Setting Page
          "AppSetting": "Setting",
          "ShowStatusSetting": "Status",
          "NotificationSetting": "Notification",
          "LanguageSetting": "Language",

          //Popup
          "WarningAdminBlocked":
              "Are you sure you\nwant to suspend this account?",
          "WarningAdminUnblocked":
              "Are you sure you want to\ncancel suspend this account?",
          "WarningBlocked":
              "Your account\nhas been suspended,\nPlease contact\nhelp center for recovery",
          "WarningLeave": "Are you sure you\nwant to leave this group ?",
          "RegisterSuccess": "Success",
          "NextButton": "Next",

          //Confirm
          "Confirm": "Confirm"
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
          //Language Info
          "InfoLangHeader": "ข้อมูลภาษา",
          "InfoLangDesc":
              "คุณไม่สามารถเปลี่ยนสัญชาติและภาษาที่หนึ่งหลังจากนี้ได้ดังนั้นโปรดให้ข้อมูลส่วนบุคคลที่แท้จริง",
          "InfoCountry": "คุณเป็นคนประเทศ",
          "InfoFirstLanguage": "ภาษาที่หนึ่ง",
          "InfoLevelFirstLanguage": "ระดับของภาษาที่หนึ่ง",
          "InfoLanguageInterest": "ภาษาที่สนใจ",
          "InfoLevelLanguageInterest": "ระดับของภาษาที่สนใจ",
          //Profile Picture Upload
          "ProfilePictureUpload": "อัปโหลดรูปภาพโพรไฟล์ของของคุณ",
          "ProfilePictureDesc":
              "กรุณาอัปโหลดรูปที่ชัดเจนไม่มีอะไรปิดบัง ไม่หันหลัง ไม่อนาจาร ไม่เกี่ยวข้องกับกับการปลุกปั่นศาสนา/การเมือง ไม่ล่อลวงเกี่ยวกับเงิน",
          "ProfilePictureWarning":
              "รูปภาพที่ถูกเลือกจะไม่สามารถแก้ไขได้กรุณาเลือกรูปอย่างระมัดระวัง",
          "ProfilePictureUploadButton": "อัพโหลดรูปภาพ",

          //Main-Application
          //Jassy Main Page
          "MainPage": "หน้าหลัก",
          "MainTabLanguage": "ระดับภาษา",
          "MainTabDesc": "คำบรรยาย",
          "MainNoUserTitle":
              "ไม่มีผู้ใช้งานที่ตรงกับความต้องการ\nของคุณในขณะนี้",
          "MainNoUserDesc": "กรุณาเลือกความต้องการที่ใกล้เคียง",
          //Filter
          "FilterLang": "ภาษา",
          "FilterLevelLang": "ระดับภาษา",
          "FilterSex": "เพศ",
          "FilterNoneGender": "ไม่ระบุ",
          "FilterAge": "อายุ",
          "FilterReset": "คืนค่า",
          "FilterPage": "ตัวกรอง",
          "FilterButton": "กรอง",

          //Jassy Like Page
          "LikePage": "ถูกใจ",
          "NoLikesTitle": "ยังไม่มีคนถูกใจคุณในขณะนี้",
          "NoLikesDesc": "เริ่มต้นค้นหาคนที่คุณถูกใจกันเถอะ !",

          //Jassy Community Page
          "CommuPage": "ชุมชน",
          "CommuRecommand": "แนะนำสำหรับคุณ",
          "CommuMore": "ดูเพิ่มเติม",
          "CommuFeed": "ข่าวสาร",
          "CommuNoFeed": "ยังไม่มีข่าวสารสำหรับคุณ",
          "CommuStartJoin":
              "เริ่มเข้ากลุ่มเพื่อรับข่าวสารและแลกเปลี่ยนกันเถอะ !",
          "CommuMyGroup": "กลุ่มของฉัน",
          "CommuSearch": "ค้นหา",
          "CommuSearchGroup": "ค้นหากลุ่ม",
          "CommuSearchInterest": "ค้นหากลุ่มที่สนใจ",
          "CommuFindGroup": "ค้นหากลุ่ม",
          "CommuResults": "ผลลัพธ์การค้นหา",
          //Group Activity
          "GroupActivity": "กิจกรรมของกลุ่ม",
          "GroupJoin": "เข้าร่วมกลุ่ม",
          "GroupMember": "สมาชิก",
          "GroupNotificationOff": "ปิดการแจ้งเตือนกลุ่ม",
          "GroupNotificationOn": "เปิดการแจ้งเตือนกลุ่ม",
          "GroupLeave": "ออกจากกลุ่ม",
          "GroupPostHeader": "เขียนโพสต์",
          "GroupPostButton": "โพสต์",
          "GroupPostHintText": "คุณกำลังคิดอะไรอยู่",
          "GroupPostAddPic": "รูปภาพ/วิดีโอ",
          "GroupPostReport": "รายงานโพสต์",
          "GroupPostDelete": "ลบโพสต์",
          "GroupPostNotiOff": "ปิดการแจ้งเตือนสำหรับโพสต์นี้",
          "GroupPostNotiOn": "เปิดการแจ้งเตือนสำหรับโพสต์นี้",
          "GroupPostBy": "เขียนโดย",
          "GroupPostAt": "เมื่อ",
          "GroupPostToday": "วันนี้",
          "GroupPostYesterday": "เมื่อวานนี้",
          "GroupPostCommentHintText": "เขียนคอมเมนต์",
          "GroupDeleteWarning": "คุณต้องการลบโพสต์นี้ใช่หรือไม่ ?",

          //Jassy Chat Page
          "ChatPage": "แชท",
          "HeaderChatPage": "สนทนา",
          "SearchChat": "ค้นหา",
          "ChatRead": "อ่านแล้ว",
          "ChatHintText": "พิมพ์ข้อความ",
          "ChatShowReport": "ไม่สามารถส่งข้อความกับบุคคลนี้ได้อีก",
          "NoChatPartner": "คุณยังไม่มีคู่สนทนาในขณะนี้",
          "FindChatPartner":
              "เริ่มต้นค้นหาคู่สนทนาเพื่อแลกเปลี่ยนภาษากันเถอะ !",
          //Appbar Chat
          "StatusActiveNow": "กำลังใช้งาน",
          "StatusActiveAfew": "ใช้งานเมื่อไม่กี่นาทีที่แล้ว",
          "StatusActive": "ใช้งานเมื่อ",
          "StatusActiveMins": " นาทีที่แล้ว",
          "StatusActiveHours": " ชั่วโมงที่แล้ว",
          "StatusActiveDays": " วันที่แล้ว",
          "MenuNotificationOn": "เปิดการแจ้งเตือน",
          "MenuNotificationOff": "ปิดการแจ้งเตือน",
          "MenuUnmatch": "ยกเลิกการจับคู่",
          "MenuReport": "รายงาน",
          //unmatch
          "WarningUnmatch": "คุณต้องการยกเลิกการจับคู่ใช่หรือไม่ ?",
          "WarningReport": "คุณต้องการรายงานผู้ใช้รายนี้ใช่หรือไม่ ?",
          "WarningReportPost": "คุณต้องการรายงานโพสต์นี้ใช่หรือไม่ ?",
          //Report
          "ReportDetail": "รายละเอียดการรายงาน",
          "ReportWarning":
              "คุณจะไม่สามารถเห็นผู้ใช้งานนี้ได้อีก แน่ใจหรือไม่ที่จะรายงาน",
          "ReportFill": "กรุณากรอก",
          "ReportAttach": "แนบหลักฐานการรายงาน",
          "ReportAddFile": "เพิ่มรูปภาพ",
          "ReportChoose": "โปรดเลือกปัญหา",
          "ReportDesc":
              "หากท่านรู้สึกตกอยู่ในอันตราย โปรดขอความช่วยเหลือก่อนรายงานปัญหาให้กับแจสซี่ทราบ",
          "ReportNudity": "ภาพโป๊เปลือย",
          "ReportVio": "ความรุนแรง",
          "ReportThreat": "การคุกคาม",
          "ReportProfan": "คำหยาบคาย",
          "ReportTerro": "การก่อการร้าย",
          "ReportChild": "การใช้แรงงานเด็ก",
          "ReportSexual": "การแสวงหาผลประโยชน์ทางเพศ",
          "ReportAnimal": "การทำร้ายทารุณสัตว์",
          "ReportScam": "หลอกลวงต้มตุ๋น",
          "ReportAbuse": "สนับสนุนการใช้สารเสพติด",
          "ReportOther": "อื่น ๆ",

          //Jassy Profile Page
          "ProfilePage": "โพรไฟล์",
          "ProfileSetting": "ตั้งค่าโพรไฟล์",
          "ProfileHelp": "ศูนย์ช่วยเหลือ",
          "ProfileAppSetting": "การตั้งค่า",
          "ProfileMarkAsLike": "ข้อความที่ชื่นชอบ",
          "ProfileSavedPost": "รายการที่บันทึกไว้",
          "ProfileSavedPostBy": "โพสต์จาก ",
          "ProfileSeeSavedPost": "ดูโพสต์ต้นฉบับ",
          "ProfileRemoveSavedPost": "เลิกบันทึก",
          "ProfileAboutJassy": "เกี่ยวกับแจสซี่",
          "ProfileLogOut": "ออกจากระบบ",

          //Profile Setting Page
          "ProfileDesc": "คำบรรยายของคุณ",
          "ProfileSaveChange": "บันทึกการเปลี่ยนแปลง",
          "ProfileTabInfo": "ข้อมูลส่วนตัว",
          "ProfileTabLang": "ภาษา",

          //Setting Page
          "AppSetting": "ศูนย์ช่วยเหลือ",
          "ShowStatusSetting": "การแสดงสถานะของคุณ",
          "NotificationSetting": "การแจ้งเตือน",
          "LanguageSetting": "ภาษา",

          //Popup
          "WarningAdminBlocked": "คุณต้องการระงับ\nการใช้งานผู้ใช้รายนี้ ?",
          "WarningAdminUnblocked":
              "คุณต้องการยกเลิกระงับ\nการใช้งานผู้ใช้รายนี้ ?",
          "WarningBlocked":
              "บัญชีของคุณถูกระงับการใช้งาน\nหากต้องการกู้คืนบัญชี\nกรุณาติดต่อศูนย์ช่วยเหลือผู้ใช้",
          "WarningLeave": "คุณต้องการออกจากกลุ่มนี้ ?",
          "RegisterSuccess": "ลงทะเบียนสำเร็จ",
          "NextButton": "ต่อไป",

          //Confirm
          "Confirm": "ตกลง"
        },
      };
}
