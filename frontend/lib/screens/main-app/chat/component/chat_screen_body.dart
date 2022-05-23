import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/chat_selected_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/edit_chatlist.dart';
import 'package:flutter_application_1/screens/main-app/community/component/no_news_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  bool isSelected = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController = TextEditingController();
    // searchController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: ChatSelectedAppBar(
        text: "HeaderChatPage".tr,
        action: IconButton(
          onPressed: () {
            // Todo: go to edit chat list
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditChatList()),
            );
          },
          icon: SvgPicture.asset(
            'assets/icons/list_check.svg',
          ),
          color: primaryDarker,
        ),
      ),
      body: Column(
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (desc) {
                desc = searchController.text;
                setState(() {});
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search_input.svg',
                  height: 16,
                ),
                hintText: 'SearchChat'.tr,
                filled: true,
                fillColor: textLight,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: textLight, width: 0.0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: const BorderSide(color: textLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: const BorderSide(color: textLight),
                ),
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  //call all chatroom
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .where('uid', isEqualTo: currentUser!.uid)
                      .snapshots(includeMetadataChanges: true),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Lottie.asset("assets/images/loading.json"),
                      );
                    }
                    if (snapshot.data!.docs[0]['chats'].length == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NoNewsWidget(
                            size: size,
                            headText: "NoChatPartner".tr,
                            descText: "FindChatPartner".tr,
                          ),
                        ],
                      );
                    }
                    var listChatid = snapshot.data!.docs[0]['chats'];
                    var data = snapshot.data!.docs[0];
                    return StreamBuilder<QuerySnapshot>(
                      //call list chat id
                      stream: FirebaseFirestore.instance
                          .collection('ChatRooms')
                          .where('chatid')
                          .snapshots(includeMetadataChanges: true),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Lottie.asset("assets/images/loading.json"),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        var listChat = snapshot.data!.docs;
                        List userList = [];

                        for (var chatid in listChatid) {
                          for (var chat in listChat) {
                            if (chatid == chat['chatid']) {
                              userList.add(chat);
                            }
                          }
                        }
                        userList.sort((a, b) {
                          return DateFormat('dd/MM/yyyy KK:mm a')
                              .format(DateTime.parse(
                                  b['lastTimestamp'].toDate().toString()))
                              .compareTo(DateFormat('dd/MM/yyyy KK:mm a')
                                  .format(DateTime.parse(
                                      a['lastTimestamp'].toDate().toString())));
                        });

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          itemCount: userList.length,
                          itemBuilder: (context, int index) {
                            return ChatCard(
                              chat: userList[index],
                              currentUser: data,
                              query: searchController.text.toLowerCase(),
                            );
                          },
                        );
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
