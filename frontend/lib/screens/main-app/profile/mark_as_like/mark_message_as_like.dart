import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/mark_message_as_like_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/delete_popup.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/screens/main-app/profile/mark_as_like/like_list_detail.dart';
import 'package:flutter_application_1/screens/main-app/profile/mark_as_like/message_as_like_detail.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:get/utils.dart';
import 'package:translator/translator.dart';

class MarkMessageAsLike extends StatefulWidget {
  final user;
  const MarkMessageAsLike(this.user, {Key? key}) : super(key: key);

  @override
  State<MarkMessageAsLike> createState() => _MarkMessageAsLikeState();
}

class _MarkMessageAsLikeState extends State<MarkMessageAsLike> {
  List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
  bool isSelected = false;
  bool isTranslate = false;
  final _LanguageChoicesLists = [
    'Khmer',
    'Chinese Traditional',
    'English',
    'Indonesian',
    'Japanese',
    'Korean',
    'Thai',
  ];
  int? selectedIndex;

  CollectionReference memo =
      FirebaseFirestore.instance.collection('MemoMessages');
  removeMemo(memoid, language) async {
    CollectionReference memo =
        FirebaseFirestore.instance.collection('MemoMessages');
    await memo.doc(widget.user['uid']).update({
      '$language': FieldValue.arrayRemove([memoid]),
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    getLangCode();
    super.initState();
  }

  final List locale = [
    {'name': 'Khmer', 'code': 'km'},
    {'name': 'Chinese Traditional', 'code' : 'zh-tw'},
    {'name': 'English', 'code': 'en'},
    {'name': 'Indonesian', 'code': 'id'},
    {'name': 'Japanese', 'code': 'ja'},
    {'name': 'Korean', 'code': 'ko'},
    {'name': 'Thai', 'code': 'th'},
  ];

  List translation = [];
  var langCode;

  getLangCode() async {
    for (var local in locale) {
      if (local['name'].toLowerCase() ==
          widget.user['language']['defaultLanguage'].toLowerCase()) {
        langCode = local['code'];
      }
    }
  }

  translateCard(listMemo) async {
    translation = [];
    List getListMessage = [];
    final translator = GoogleTranslator();
    for (var memo in listMemo) {
      var snapshot = await FirebaseFirestore.instance
          .collection('Messages')
          .where('messageID', isEqualTo: memo)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var message = snapshot.docs[0]['message'];
        getListMessage.add(message);
      }
    }
    for (var message in getListMessage) {
      var translationWord =
          await translator.translate(message, to: '$langCode');
      translation.add(translationWord);
    }
    print(translation);
  }

  var translationDetail;

  translate(message) async {
    final translator = GoogleTranslator();
    translationDetail = await translator.translate(message, to: '$langCode');
  }

  removeList(language) async {
    await memo.doc(widget.user['uid']).update({
      '$language': [],
    });
    Navigator.of(context).pop();
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.8,
                    width: size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('MemoMessages')
                          .where('owner', isEqualTo: widget.user['uid'])
                          .snapshots(includeMetadataChanges: true),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text(''));
                        }
                        var memo = snapshot.data!.docs[0];
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
                            itemCount: memo['listLanguage'].length,
                            itemBuilder: (context, int index) {
                              var language =
                                  memo['listLanguage'][index].toLowerCase();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  memo[language].length > 0
                                      ? Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * 0.02,
                                                  vertical: size.height * 0.02),
                                              child: Text(
                                                StringUtils.capitalize(
                                                    language),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: greyDark),
                                              ),
                                            ),
                                            Spacer(),
                                            MoreDetail(
                                                language, memo[language]),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  memo[language].length > 0
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: size.height * 0),
                                          child: GridView.builder(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            physics: const ScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio:
                                                        size.width /
                                                            size.height /
                                                            0.35,
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing:
                                                        size.height * 0.02,
                                                    mainAxisSpacing:
                                                        size.height * 0.02),
                                            itemCount:
                                                memo[language].length <= 4
                                                    ? memo[language].length
                                                    : 4,
                                            itemBuilder: (context, i) {
                                              var isSelect = isSelected;
                                              var reversed =
                                                  memo[language].length -
                                                      1 -
                                                      index;
                                              return favMassageItem(
                                                  context,
                                                  i,
                                                  memo,
                                                  language,
                                                  index,
                                                  memo['listLanguage']);
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              );
                            });
                      },
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

  Widget MoreDetail(language, listMemo) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.21,
                  padding: const EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20, bottom: 15),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.02),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            CupertinoPageRoute(
                                                builder: (context) {
                                          return LikeListDetail(
                                              language, listMemo, widget.user);
                                        }));
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/see_more.svg"),
                                          SizedBox(
                                            width: size.width * 0.05,
                                            height: size.height * 0.1,
                                          ),
                                          Text("CommuMore".tr)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DeleteWarningPopUp(
                                                  onPress: () {
                                                removeList(language);
                                              });
                                            });
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/del_bin_circle.svg"),
                                          SizedBox(
                                            width: size.width * 0.05,
                                            height: size.height * 0.1,
                                          ),
                                          Text("Delete".tr)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: primaryDarker,
                              ))),
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.more_horiz,
          color: primaryColor,
          size: size.width * 0.08,
        ));
  }

  Widget favMassageItem(context, i, memo, language, index, listLanguage) {
    List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
    Size size = MediaQuery.of(context).size;
    bool isCheck = false;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Messages')
            .where('messageID', isEqualTo: memo[language][i])
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var message = snapshot.data!.docs[0];
          return InkWell(
            onTap: () async {
              int color = index.toInt() % colors.length.toInt();
              await translate(message['message']);
              isSelected == false
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessageAsLikeDetail(
                                color: color,
                                message: message,
                                language: language,
                                translate: translationDetail,
                              )))
                  : Container();
            },
            child: Container(
              padding: EdgeInsets.all(size.height * 0.015),
              color: colors[index.toInt() % colors.length.toInt()],
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: isSelected
                          ? Container()
                          : InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DeleteWarningPopUp(onPress: () {
                                        removeMemo(memo[language][i], language);
                                      });
                                    });
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/del_bin.svg"))),
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: message['type'] == 'text'
                        ? Text(
                            message['message'],
                            style: TextStyle(fontSize: 16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            'Type is not available',
                            style: TextStyle(fontSize: 16, color: textMadatory),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
