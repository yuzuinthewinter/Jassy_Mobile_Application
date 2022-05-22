import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/body/successWithButton_body.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/report/listReportUser.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/detail_page.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RequestDetailPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final request;
  final user;
  // ignore: use_key_in_widget_constructors
  const RequestDetailPage(this.request, this.user);

  @override
  State<RequestDetailPage> createState() => _RequestDetailPage();
}

class _RequestDetailPage extends State<RequestDetailPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference suspend =
      FirebaseFirestore.instance.collection('SuspendedUser');

  warningCancelBlocked() async {
    await users.doc(widget.user['uid']).update({
      'userStatus': 'user',
    });
    await suspend.doc(widget.request['requestId']).delete();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  warningRemoveRequest() async {
    await suspend.doc(widget.request['requestId']).delete();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BackAndCloseAppBar(),
      body: Column(
        children: [
          ProfilePictureWidget(size: size, user: widget.user),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            '${StringUtils.capitalize(widget.user['name']['firstname'])} ${StringUtils.capitalize(widget.user['name']['lastname'])}',
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          Text(
            'จำนวนการร้องเรียนโดยผู้ใช้ : ${widget.user['report'].length}',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'kanit',
              fontWeight: FontWeight.w400,
              color:
                  widget.user['report'].length >= 3 ? textMadatory : textDark,
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Text(
            StringUtils.capitalize(widget.request['requestHeader']),
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: widget.request['requestDetail'],
                hintStyle: const TextStyle(color: greyDark),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                fillColor: textLight,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: textLight, width: 0.0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: textLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: textLight),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButtonComponent(
                    text: "ลบคำร้องขอ",
                    minimumSize: Size(size.width * 0.3, size.height * 0.05),
                    press: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return WarningPopUpWithButton(
                              text: 'คุณแน่ใจหรือไม่ว่าต้องการลบคำร้องขอนี้ ?',
                              okPress: () {
                                warningRemoveRequest();
                              },
                            );
                          });
                    }),
                SizedBox(
                  width: size.width * 0.04,
                ),
                RoundButton(
                    text: "ยกเลิกระงับการใช้งานผู้ใช้",
                    minimumSize: Size(size.width * 0.3, size.height * 0.05),
                    press: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return WarningPopUpWithButton(
                              text: 'WarningAdminUnblocked'.tr,
                              okPress: () {
                                warningCancelBlocked();
                              },
                            );
                          });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
