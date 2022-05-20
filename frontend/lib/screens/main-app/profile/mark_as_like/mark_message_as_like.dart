import 'package:cloud_firestore/cloud_firestore.dart';
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

class MarkMessageAsLike extends StatefulWidget {
  final user;
  const MarkMessageAsLike(this.user, {Key? key}) : super(key: key);

  @override
  State<MarkMessageAsLike> createState() => _MarkMessageAsLikeState();
}

class _MarkMessageAsLikeState extends State<MarkMessageAsLike> {
  List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
  bool isSelected = false;
  final _LanguageChoicesLists = ['Thai', 'Korean', 'Indonesian'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MarkMessageAsLikeAppBar(
        actionWidget: IconButton(
          onPressed: () {
            print(isSelected);
            setState(() {
              isSelected = !isSelected;
            });
          },
          icon: isSelected
              ? Text(
                  "ลบ",
                  style: TextStyle(fontSize: 18, color: textMadatory),
                )
              : const Icon(Icons.check_circle_outline_rounded),
          color: primaryDarker,
        ),
      ),
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
                          return const Center(child: Text('Save something'));
                        }
                        var memo = snapshot.data!.docs[0];
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            itemCount: memo['listLanguage'].length,
                            itemBuilder: (context, int index) {
                              var language =
                                  memo['listLanguage'][index].toLowerCase();
                              return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02,
                                          vertical: size.height * 0.02),
                                      child: Text(
                                        StringUtils.capitalize(language),
                                        style: TextStyle(
                                            fontSize: 20, color: greyDark),
                                      ),
                                    ), 
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: size.height * 0),
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
                                          itemCount: memo[language].length,
                                          itemBuilder: (context, i) {
                                            var isSelect = isSelected;
                                            return favMassageItem(context, i, memo, language, index);
                                          },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            );
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

  removeMemo(memoid, language) async {
    CollectionReference memo = FirebaseFirestore.instance
                          .collection('MemoMessages');
    await memo.doc(widget.user['uid']).update({
      '$language': FieldValue.arrayRemove([memoid]),
    });
    Navigator.of(context).pop();
  }

  Widget favMassageItem(context, i, memo, language, index) {
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
      onTap: () {
        // go to detail page
        int color = (index % memo['listLanguage'].length).toInt();
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessageAsLikeDetail(
                          color: color,
                          message: message['message'],
                        )));
      },
      child: Container(
        padding: EdgeInsets.all(size.height * 0.015),
        color: colors[(index % memo['listLanguage'].length).toInt()],
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: isSelected
                    ? InkWell(
                        onTap: () {
                          // Todo: setState is not update
                          setState(() {
                            isCheck == !isCheck;
                          });
                          print('${memo[language][i]} + $isCheck');
                        },
                        child: 
                        isCheck
                            ? SvgPicture.asset("assets/icons/check_circle.svg")
                            : 
                            SvgPicture.asset(
                                "assets/icons/uncheck_circle.svg"))
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
                        child: SvgPicture.asset("assets/icons/del_bin.svg"))),
            SizedBox(height: size.height * 0.01),
            Align(
              alignment: Alignment.center,
              child: message['type'] == 'text' ? Text(
                message['message'],
                style: TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ) : Text(
                'Type is not available',
                style: TextStyle(fontSize: 16, color: textMadatory),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );});
    
  }
}
