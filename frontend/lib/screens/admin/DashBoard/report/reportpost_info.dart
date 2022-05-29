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
import 'package:flutter_application_1/controllers/currentUser.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/report/listReportPost.dart';
import 'package:flutter_application_1/screens/main-app/community/post_detail.dart';
import 'package:flutter_application_1/screens/main-app/jassy_homepage/component/detail_page.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReportPostInfoPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final report;
  // ignore: use_key_in_widget_constructors
  const ReportPostInfoPage(this.report);

  @override
  State<ReportPostInfoPage> createState() => _ReportPostInfoPage();
}

class _ReportPostInfoPage extends State<ReportPostInfoPage> {
  deletePost(postid, groupid) async {
    CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
    CollectionReference groups =
        FirebaseFirestore.instance.collection('Community');
    CollectionReference report =
        FirebaseFirestore.instance.collection('ReportPost');
    await posts.doc(postid).delete();
    await groups.doc(groupid).update({
      'postsID': FieldValue.arrayRemove([postid]),
    });
    var snapshot =
        await report.where('postid', isEqualTo: widget.report['postid']).get();
    if (snapshot.docs.isNotEmpty) {
      List<QueryDocumentSnapshot> doc = snapshot.docs;
      if (doc.length > 1) {
        for (var docid in doc) {
          DocumentReference docRef = docid.reference;
          await report.doc(docRef.id).delete();
        }
      } else if (doc.length == 1) {
        DocumentReference docRef = doc[0].reference;
        await report.doc(docRef.id).delete();
      }
    }
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
          CurvedWidget(child: JassyGradientColor()),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            widget.report['reportHeader'],
            style: const TextStyle(
                fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: Container(
                        constraints:
                            const BoxConstraints(maxHeight: double.infinity),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.report['reportDetail'],
                              maxLines: null,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Text(
                              'หลักฐานการรายงาน',
                              maxLines: null,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                context.pushTransparentRoute(InteractiveViewer(
                                  child: ImageMessageDetail(
                                      urlImage: widget.report['reportImage']),
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      padding:
                          EdgeInsets.symmetric(horizontal: size.height * 0.025),
                      width: size.width,
                      height: size.height * 0.075,
                      decoration: BoxDecoration(
                          color: textLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        Expanded(
                            child: InkWell(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/see_post.svg"),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                "ดูโพสต์ต้นฉบับ",
                                style: TextStyle(color: textDark),
                              ),
                              // Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                            ],
                          ),
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return PostDetail(
                                postid: widget.report['postid'],
                              );
                            }));
                          },
                        )),
                      ]),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      padding:
                          EdgeInsets.symmetric(horizontal: size.height * 0.025),
                      width: size.width,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                          color: textLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Community')
                              .where('postsID',
                                  arrayContains: widget.report['postid'])
                              .snapshots(includeMetadataChanges: true),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text(''),
                              );
                            }
                            var group = snapshot.data!.docs[0];
                            return Column(children: [
                              Expanded(
                                  child: InkWell(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/report_red.svg"),
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
                                    return ListReportPostScreen(
                                        widget.report['postid']);
                                  }));
                                },
                              )),
                              Expanded(
                                child: InkWell(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/report_red.svg"),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Text(
                                        "ระงับการใช้งานโพสต์นี้",
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
                                            text: 'GroupDeleteWarning'.tr,
                                            okPress: () {
                                              deletePost(
                                                  widget.report['postid'],
                                                  group['groupid']);
                                            },
                                          );
                                        });
                                  },
                                ),
                              ),
                            ]);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
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
