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
          "LandingPrivacy": "Privacy Policy",
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
          "PhoneWarning" : "Please fill out the information completely.",
          //OTP comfirmed page
          "OtpPageFilled": "Enter OTP code",
          "OtpPageDesc":
              "Please enter the OTP you received via your phone number within the time limit.",
          "OtpTimeout": "This OTP will expire in 5 minutes.",
          "OtpResend": "Resend",
          "OtpWrong": "You have entered an invalid otp , please try again.",
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
          "ValidateAge": "You are not of legal age to create an account.",
          //Language Info
          "InfoLangHeader": "Language Information",
          "InfoLangDesc":
              "You can not change your nationality and mother tongue after this, So please provide real personal information.",
          "InfoCountry": "Country",
          "InfoFirstLanguage": "First Language",
          "InfoLevelFirstLanguage": "Level of First Language",
          "InfoLanguageInterest": "Language Interest",
          "InfoLevelLanguageInterest": "Level of Language Interest",
          //handle phase one
          "PhaseOneSuccessHeader": "Step One\nRegistration is Successful.",
          "PhaseOneSuccessDetail":
              "Press next step button\nto verify your identity by face.",
          "PhaseOneGoToApp": "Go to App",
          "PhaseOneGoToPhaseTwo": "Next Step",
          //Profile Picture Upload
          "ProfilePictureUpload": "Please upload your profile picture.",
          "ProfilePictureDesc":
              "Please upload a clear picture. Don't look back, obscene, involved in religious/political provocation and don't deceive money.",
          "ProfilePictureWarning":
              "The selected picture cannot be edited, please select the picture carefully.",
          "ProfilePictureUploadButton": "Upload Image",
          "WarningPictureMoreThanOnePerson":
              "Please upload\na single photo of yourself.",
          "WarningPictureNoOne": "Please upload\nan identity picture.",
          "WarningDetected": "Detected",
          "WarningPersons": "Persons",
          "WarningTakePictureMoreThanOnePerson":
              "Please take a picture of yourself.",
          "WarningTakePictureNoOne": "Please take a identity picture.",
          "Smile" : "Please smile and take a picture.",
          "PleaseSmile" : "Please smile.",

          //Handle phase two 
          "PhaseTwoSuccessHeader": "Registration is Successful.",
          "PhaseTwoSuccessDetail":
              "Press button to start exchange languages.",
          "PhaseTwoFail" : "Your face doesn't match\nPlease try again",

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
          "CommuSavePost" : "Save post",
          //Group Activity
          "GroupActivity": "Group Activities",
          "GroupJoin": "Join Group",
          "GroupWarningJoin": "You have to join this group first",
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
          "GroupCommenDeleteWarning": "Are you want to delete this comment ?",

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
          "DeleteConversation": "Delete conversation",
          "Reply": "Reply",
          "Copy": "Copy",
          "Translate": "Translate",
          "LikeMassage": "Like",
          "RemoveMessage": "removed a message.",
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

          //Help Center
          "unverifiedUsers": "For unverified users",
          "CommunityFeedback": "Community feedback",
          "SuspendedUsers": "For suspended users",
          "FeedBack": "Feedback",
          "FeedBackDetail": "Feedback details",
          "RequestTitle": "File a petition that has been suspended",
          "RequestDetail": "Petition details",

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
          "WarningAuthUser":
              "Registration is not complete yet,\nPlease register again.",
          "WarningLeave": "Are you sure you\nwant to leave this group ?",
          "RegisterSuccess": "Success",
          "NextButton": "Next",
          "WarningDelete" : "Are you sure you want to delete the selected item?",

          //About Jassy
          "AboutJassyApp":
              "The purposes of this project are to develop the Jassy application that is used to exchange knowledge and interests in languages, and to enable users to use it in the exchange of languages and knowledge who are interested and would like to develop a language directly with native speakers.\nThe project can meet the needs of the target audiences who desire to develop language potential, or discuss language exchange with native speakers, as well as exchange knowledge and skills with which this application can exchange knowledge through the communities that are provided.\nThe community will be categorized by language. The application exchanges only in Thai and English. It also offers one-on-one language exchange with native speakers or talented people through private conversations, with the option of qualifying for yourself and a wide range of functions that will encourage you to exchange languages more vividly.",
          "ContactJassy": "Contact: jassygroup@gmail.com",

          //Confirm
          "Confirm": "Confirm",
          "Agree": "Agree",
          "Cancel": "Cancel",
          "Delete": "Delete",
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
          "PhoneWarning" : "กรุณากรอกข้อมูลให้ครบถ้วน",
          //OTP comfirmed page
          "OtpPageFilled": "กรุณาใส่รหัสลับ",
          "OtpPageDesc":
              "กรุณาใส่รหัส OTP ที่คุณได้รับผ่านหมายเลขโทรศัพท์ของคุณภายในเวลาที่กำหนด",
          "OtpTimeout": "รหัสนี้จะหมดเวลาภายใน 5 นาที",
          "OtpResend": " ส่งใหม่",
          "OtpWrong": "คุณกรอกรหัส OTP ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง",
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
          "ValidateAge": "คุณอายุยังไม่ถึงเกณฑ์ที่จะสร้างบัญชี",
          //Language Info
          "InfoLangHeader": "ข้อมูลภาษา",
          "InfoLangDesc":
              "คุณไม่สามารถเปลี่ยนสัญชาติและภาษาที่หนึ่งหลังจากนี้ได้ดังนั้นโปรดให้ข้อมูลส่วนบุคคลที่แท้จริง",
          "InfoCountry": "คุณเป็นคนประเทศ",
          "InfoFirstLanguage": "ภาษาที่หนึ่ง",
          "InfoLevelFirstLanguage": "ระดับของภาษาที่หนึ่ง",
          "InfoLanguageInterest": "ภาษาที่สนใจ",
          "InfoLevelLanguageInterest": "ระดับของภาษาที่สนใจ",
          //handle phase one
          "PhaseOneSuccessHeader": "ขั้นตอนที่ 1\nการลงทะเบียนข้อมูลสำเร็จ",
          "PhaseOneSuccessDetail": "กดถัดไปเพื่อยืนยันตัวตนด้วยใบหน้า",
          "PhaseOneGoToApp": "ไปยังหน้าหลัก",
          "PhaseOneGoToPhaseTwo": "ต่อไป",
          //Profile Picture Upload
          "ProfilePictureUpload": "อัปโหลดรูปภาพโพรไฟล์ของของคุณ",
          "ProfilePictureDesc":
              "กรุณาอัปโหลดรูปที่ชัดเจนไม่มีอะไรปิดบัง ไม่หันหลัง ไม่อนาจาร ไม่เกี่ยวข้องกับกับการปลุกปั่นศาสนา/การเมือง ไม่ล่อลวงเกี่ยวกับเงิน",
          "ProfilePictureWarning":
              "รูปภาพที่ถูกเลือกจะไม่สามารถแก้ไขได้กรุณาเลือกรูปอย่างระมัดระวัง",
          "ProfilePictureUploadButton": "อัพโหลดรูปภาพ",
          "WarningPictureMoreThanOnePerson":
              "กรุณาอัปโหลด\nรูปที่มีคุณเพียงคนเดียว",
          "WarningPictureNoOne": "กรุณาอัปโหลดรูปที่มีตัวตน",
          "WarningDetected": "ตรวจพบ",
          "WarningPersons": "คน",
          "WarningTakePictureMoreThanOnePerson":
              "กรุณาถ่ายรูปที่มีคุณเพียงคนเดียว",
          "WarningTakePictureNoOne": "กรุณาถ่ายรูปที่มีตัวตน",
          "Smile" : "กรุณายิ้ม แล้วกดถ่ายภาพ",
          "PleaseSmile" : "กรุณายิ้ม",

           //Handle phase two 
          "PhaseTwoSuccessHeader": "การลงทะเบียนสำเร็จ",
          "PhaseTwoSuccessDetail":
              "กดปุ่มเพื่อเริ่มแลกเปลี่ยนภาษา",
          "PhaseTwoFail" : "ใบหน้าของคุณไม่ตรงกัน\nกรุณาลองใหม่อีกครั้ง",

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
          "CommuSavePost" : "บันทึกโพสต์",
          //Group Activity
          "GroupActivity": "กิจกรรมของกลุ่ม",
          "GroupJoin": "เข้าร่วมกลุ่ม",
          "GroupWarningJoin": "โปรดเข้าร่วมกลุ่มเพื่อรับข่าวสาร",
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
          "GroupCommenDeleteWarning": "คุณต้องการลบคอมเมนต์นี้ใช่หรือไม่ ?",

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
          "DeleteConversation": "ลบการสนทนา",
          "Reply": "ตอบกลับ",
          "Copy": "คัดลอก",
          "Translate": "แปลภาษา",
          "LikeMassage": "ชอบ",
          "RemoveMessage": "ลบข้อความแล้ว",
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

          //Help Center
          "unverifiedUsers": "สำหรับผู้ใช้ที่ยังไม่ยืนยันตัวตน",
          "CommunityFeedback": "ข้อเสนอแนะสำหรับชุมชน",
          "SuspendedUsers": "สำหรับผู้ใช้ที่โดนระงับการใช้งาน",
          "FeedBack": "ข้อเสนอแนะ",
          "FeedBackDetail": "รายละเอียดข้อเสนอแนะ",
          "RequestTitle": "ยื่นคำร้องการถูกระงับการใช้งาน",
          "RequestDetail": "รายระเอียดการยื่นคำร้อง",

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
          "WarningAuthUser":
              "การลงทะเบียนเข้าใช้งานยังไม่สมบูรณ์\nกรุณาลงทะเบียนใหม่",
          "WarningLeave": "คุณต้องการออกจากกลุ่มนี้ ?",
          "RegisterSuccess": "ลงทะเบียนสำเร็จ",
          "NextButton": "ต่อไป",
          "WarningDelete" : "คุณแน่ใจหรือไม่ว่าต้องการลบรายการที่เลือก",

          //About Jassy
          "AboutJassyApp":
              "การจัดทำโครงงานนี้มีวัตถุประสงค์เพื่อสร้างแอปพลิเคชั่น Jassy ที่ใช้ในการแลกเปลี่ยนความรู้และความสนใจทางด้านภาษาและเพื่อให้ผู้ใช้สามารถใช้งานในการแลกเปลี่ยนภาษาและความรู้ที่สนใจและอยากจะพัฒนาภาษากับเจ้าของภาษาโดยตรง\nซึ่งสามารถตอบสนองความต้องการของกลุ่มเป้าหมายที่ มีความต้องการที่จะพัฒนาศักยภาพทางภาษา หรือมีความต้องการที่จะพูดคุยแลกเปลี่ยนภาษากับเจ้าของภาษารวมไปถึงแลกเปลี่ยนความรู้ทักษะต่างๆกับการสร้างความรู้ผ่านชุมชนที่เรามีให้ซึ่งชุมชนของเราก็จะแบ่งหมวดหมู่ไปตามภาษา\nซึ่งแอปพลิเคชั่นนี้สามารถใช้งานได้เพียงภาษาไทยและอังกฤษ เท่านั้น รวมถึงสามารถแลกเปลี่ยนภาษาตัวต่อตัวกับเจ้าของภาษาหรือผู้ที่มีความสามารถได้ผ่านการสนทนาส่วนตัวโดยสามารถเลือกคุณสมบัติที่เหมาะสมกับตัวของคุณเองได้\nอีกทั้งมีฟังก์ชันหลากหลายที่จะช่วยส่งเสริมให้คุณสามารถแลกเปลี่ยนภาษาได้อย่างมีประสิทธิ์ภาพมากขึ้น",
          "ContactJassy": "ติดต่อ: jassygroup@gmail.com",

          //Confirm
          "Confirm": "ตกลง",
          "Agree": "ยอมรับ",
          "Cancel": "ยกเลิก",
          "Delete": "ลบ",
        },
      };
}
