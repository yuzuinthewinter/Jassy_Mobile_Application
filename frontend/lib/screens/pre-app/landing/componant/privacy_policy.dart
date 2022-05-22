import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';

class PrivacyPolicy extends StatelessWidget {

  final VoidCallback okPress;

  const PrivacyPolicy({
    Key? key, required this.okPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        height: size.height * 0.6,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: size.height * 0.02),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.03,),
              HeaderText(text: "LandingPrivacy".tr),
              const Divider(
                height: 30,
                thickness: 2,
                indent: 20,
                endIndent: 0,
                color: textDark,
              ),
              const HeaderText(text: "Introduction"),
              const DescriptionText(text: "Our privacy policy will help you understand what information we collect at Jassy Exchanges Language, how Jassy Exchanges Language uses it, and what choices you have. Jassy Exchanges Language built the Jassy Exchanges Language app as a free app. This SERVICE is provided by Jassy Exchanges Language at no cost and is intended for use as is. If you choose to use our Service, then you agree to the collection and use of information in relation with this policy. The Personal Information that we collect are used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible in our website, unless otherwise defined in this Privacy Policy."),
              const HeaderText(text: "Information Collection and Use"),
              const DescriptionText(text: "For a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to users name, email address, gender, location, pictures. The information that we request will be retained by us and used as described in this privacy policy. \nThe app does use third party services that may collect information used to identify you."),
              const HeaderText(text: "Cookies"),
              const DescriptionText(text: "Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your devices’s internal memory."),
              const DescriptionText(text: "This Services does not uses these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collection information and to improve their services. You have the option to either accept or refuse these cookies, and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service."),
              const HeaderText(text: "Location Information"),
              const DescriptionText(text: "Some of the services may use location information transmitted from users' mobile phones. We only use this information within the scope necessary for the designated service."),
              const HeaderText(text: "Device Information"),
              const DescriptionText(text: "We collect information from your device in some cases. The information will be utilized for the provision of better service and to prevent fraudulent acts. Additionally, such information will not include that which will identify the individual user."),
              const HeaderText(text: "Service Providers"),
              const DescriptionText(text: "We may employ third-party companies and individuals due to the following reasons:"),
              const DescriptionText(text: "• To facilitate our Service"),
              const DescriptionText(text: "• To provide the Service on our behalf"),
              const DescriptionText(text: "• To perform Service-related services or"),
              const DescriptionText(text: "We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose."),
              const DescriptionText(text: "• To assist us in analyzing how our Service is used."),
              const HeaderText(text: "Security"),
              const DescriptionText(text: "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security."),
              const HeaderText(text: "Children’s Privacy"),
              const DescriptionText(text: "This Services do not address anyone under the age of 13. We do not knowingly collect personal identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions."),
              const HeaderText(text: "Changes to This Privacy Policy"),
              const DescriptionText(text: "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page."),
              const HeaderText(text: "Contact Us"),
              const DescriptionText(text: "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us.\nContact Information:\njassygroup@gmail.com"),
              SizedBox(height: size.height * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButtonComponent(text: "Cancel".tr, minimumSize: Size(size.width * 0.3, size.height * 0.05), press: () {Navigator.of(context).pop();}),
                  SizedBox(width: size.width * 0.04,),
                  RoundButton(
                    text: "Agree".tr, 
                    minimumSize: Size(size.width * 0.3, size.height * 0.05), 
                    press: okPress
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}