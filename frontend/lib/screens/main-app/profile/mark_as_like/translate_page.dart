import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/mark_message_as_like_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/delete_popup.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/screens/main-app/profile/mark_as_like/message_as_like_detail.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:get/utils.dart';
import 'package:translator/translator.dart';

class TranslateAllPage extends StatefulWidget {
  final language;
  final listWord;
  final user;
  const TranslateAllPage(this.language, this.listWord, this.user, {Key? key})
      : super(key: key);

  @override
  State<TranslateAllPage> createState() => _TranslateAllPage();
}

class _TranslateAllPage extends State<TranslateAllPage> {
  List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MarkMessageAsLikeAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.8,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02,
                                  vertical: size.height * 0.02),
                              child: Text(
                                StringUtils.capitalize(widget.language),
                                style: TextStyle(fontSize: 20, color: greyDark),
                              ),
                            ),
                            const Spacer()
                          ],
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: size.height * 0),
                          child: GridView.builder(
                            padding: const EdgeInsets.only(top: 0),
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:
                                        size.width / size.height / 0.35,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: size.height * 0.02,
                                    mainAxisSpacing: size.height * 0.02),
                            itemCount: widget.listWord.length,
                            itemBuilder: (context, i) {
                              // return Text(widget.listWord[i].toString());
                              return favMassageItem(context, i);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget favMassageItem(context, i) {
    List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
    Size size = MediaQuery.of(context).size;
    bool isCheck = false;
    return InkWell(
      onTap: () {
        int color = i.toInt() % colors.length.toInt();
        // isSelected == false
        //     ? Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => MessageAsLikeDetail(
        //                   color: color,
        //                   message: widget.listWord[i],
        //                   language: widget.language,
        //                 )))
        //     :
        Container();
      },
      child: Container(
        padding: EdgeInsets.all(size.height * 0.015),
        color: colors[i.toInt() % colors.length.toInt()],
        child: Stack(
          children: [
            Align(alignment: Alignment.topRight, child: Container()),
            SizedBox(height: size.height * 0.01),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.listWord[i].toString(),
                style: TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
