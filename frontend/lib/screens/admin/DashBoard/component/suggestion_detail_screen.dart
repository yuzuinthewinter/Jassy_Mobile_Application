import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
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

class SuggestDetailPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final suggest;
  // ignore: use_key_in_widget_constructors
  const SuggestDetailPage(this.suggest);

  @override
  State<SuggestDetailPage> createState() => _SuggestDetailPage();
}

class _SuggestDetailPage extends State<SuggestDetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BackAndCloseAppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('uid', isEqualTo: widget.suggest['suggestBy'])
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(''),
            );
          }
          var user = snapshot.data!.docs[0];
          return Column(
            children: [
              ProfilePictureWidget(size: size, user: user),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                '${StringUtils.capitalize(user['name']['firstname'])} ${StringUtils.capitalize(user['name']['lastname'])}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'kanit',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'kanit',
                      fontWeight: FontWeight.w400,
                      color: textDark,
                    ),
                    children: [
                      TextSpan(
                          text:
                              '${StringUtils.capitalize(user['language']['defaultLanguage'])} '),
                      const WidgetSpan(
                          child: Icon(
                        Icons.sync_alt,
                        size: 20,
                        color: textDark,
                      )),
                      TextSpan(
                          text:
                              ' ${StringUtils.capitalize(user['language']['interestedLanguage'])}'),
                    ]),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                StringUtils.capitalize(widget.suggest['suggestHeader']),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'kanit',
                    fontWeight: FontWeight.w600),
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
                    hintText: widget.suggest['suggestDetail'],
                    hintStyle: const TextStyle(color: greyDark),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    fillColor: textLight,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: textLight, width: 0.0)),
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
            ],
          );
        },
      ),
    );
  }
}
