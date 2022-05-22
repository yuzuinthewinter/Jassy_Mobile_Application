import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dismissible_page/dismissible_page.dart';
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

class ReportUserInfoPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final report;
  final user;
  // ignore: use_key_in_widget_constructors
  const ReportUserInfoPage(this.user, this.report);

  @override
  State<ReportUserInfoPage> createState() => _ReportUserInfoPage();
}

class _ReportUserInfoPage extends State<ReportUserInfoPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  warningChangeStatusUser() async {
    await users.doc(widget.user['uid']).update({
      'userStatus': 'blocked',
    });
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
            StringUtils.capitalize(widget.user['name']['firstname']) +
                ' ' +
                StringUtils.capitalize(widget.user['name']['lastname']),
            style: const TextStyle(
                fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
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
            height: size.height * 0.02,
          ),
          Text(
            widget.report['reportHeader'],
            maxLines: null,
            style: const TextStyle(
                fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    decoration: BoxDecoration(
                        color: textLight,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxHeight: double.infinity),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                  widget.report['reportDetail'],
                                  maxLines: null,
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                    context.pushTransparentRoute(
                                        InteractiveViewer(
                                          child: ImageMessageDetail(
                                              urlImage:
                                                  widget.report['reportImage']),
                                        ));
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: size.height * 0.2,
                                        maxWidth: double.infinity),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.report['reportImage']),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * 0.025),
                    width: size.width,
                    height: size.height * 0.14,
                    decoration: BoxDecoration(
                        color: textLight,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      Expanded(
                          child: InkWell(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.warning_rounded),
                              color: secoundary,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              "การรายงานอื่นๆ",
                              style: TextStyle(color: textMadatory),
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            return ListReportUserScreen(widget.user);
                          }));
                        },
                      )),
                      Expanded(
                          child: InkWell(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.warning_rounded),
                              color: secoundary,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              "ระงับการใช้งานผู้ใช้",
                              style: TextStyle(color: textMadatory),
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                          ],
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return WarningPopUpWithButton(
                                  text: 'WarningReport'.tr,
                                  okPress: () {
                                    warningChangeStatusUser();
                                  },
                                );
                              });
                        },
                      )),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
        ],
      ),
    );
  }
}

class ImageMessageDetail extends StatelessWidget {
  const ImageMessageDetail({
    Key? key,
    required this.urlImage,
  }) : super(key: key);

  final urlImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.multi,
      child: urlImage.isNotEmpty
          ? Image.network(
              urlImage,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            )
          : const SizedBox.shrink(),
    ));
  }
}
