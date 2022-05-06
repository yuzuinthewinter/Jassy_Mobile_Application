import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/change_languages_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class AppSettingBody extends StatefulWidget {
  final user;
  const AppSettingBody(this.user, {Key? key}) : super(key: key);

  @override
  State<AppSettingBody> createState() => _AppSettingBodyState();
}

class _AppSettingBodyState extends State<AppSettingBody> {
  bool online = true;
  bool notification = true;

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Text(
                      'ShowStatusSetting'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    buildOnlineSwitch()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 0),
                child: Row(
                  children: [
                    Text(
                      'NotificationSetting'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    buildNotificationSwitch()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'LanguageSetting'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    ChangeLanguagesButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOnlineSwitch() => Transform.scale(
        scale: 0.9,
        child: CupertinoSwitch(
          activeColor: primaryColor,
          value: online,
          onChanged: (value) async {
            setState(() => online = value);
            if (value == false) {
              //popup
            }
            await users.doc(currentUser!.uid).update({
              'isShowActive': value,
              'timeStamp': DateTime.now(),
            });
          },
        ),
      );

  Widget buildNotificationSwitch() => Transform.scale(
        scale: 0.9,
        child: CupertinoSwitch(
          activeColor: primaryColor,
          value: notification,
          onChanged: (value) => setState(() => notification = value),
        ),
      );
}
