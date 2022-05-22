import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/edit_chatlist_appbar.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class EditChatList extends StatefulWidget {
  const EditChatList({Key? key}) : super(key: key);

  @override
  State<EditChatList> createState() => _EditChatListState();
}

class _EditChatListState extends State<EditChatList> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('ChatRooms');

  getDate(timestamp) {
    DateTime datatime = DateTime.parse(timestamp.toDate().toString());
    String formattedTime = DateFormat('KK:mm a').format(datatime);
    return formattedTime.toString();
  }

  List checkList = [];

  unMatch() async {
    for (var chat in checkList) {
      await users.doc(chat['member'][0]).update({
        'chats': FieldValue.arrayRemove([chat['chatid']]),
        'likesby': FieldValue.arrayRemove([chat['member'][1]]),
        'liked': FieldValue.arrayRemove([chat['member'][1]]),
      });
      await users.doc(chat['member'][1]).update({
        'chats': FieldValue.arrayRemove([chat['chatid']]),
        'likesby': FieldValue.arrayRemove([chat['member'][0]]),
        'liked': FieldValue.arrayRemove([chat['member'][0]]),
      });
      await chatRooms.doc(chat['chatid']).delete();
    }
    Navigator.of(context).popAndPushNamed(Routes.JassyHome, arguments: [3, true, false]);
  }

  removeChat() async {
    // for (var chat in checkList) {
      // await users.doc(currentUser!.uid).update({
        // 'chats': FieldValue.arrayRemove([chat['chatid']]),
      // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: EditChatListAppBar(
          action: TextButton(
              onPressed: () {
                // Todo: read all
              },
              // Todo อ่าน(1)
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "เลือกทั้งหมด",
                    style: TextStyle(color: secoundary, fontSize: 16),
                  )))),
      body: Column(
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(
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
                return const Center(child: Text('Let\'s start conversation'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                itemCount: snapshot.data!.docs[0]['chats'].length,
                itemBuilder: (context, int index) {
                  var data = snapshot.data!.docs[0];
                  return StreamBuilder<QuerySnapshot>(
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
                        return const Center(
                            child: Text('Let\'s start conversation'));
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
                            return const Center(
                              child: CircularProgressIndicator(),
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
                                    .format(DateTime.parse(a['lastTimestamp']
                                        .toDate()
                                        .toString())));
                          });
                          if (userList[index]['member'].length >= 1) {
                            for (var memberId in userList[index]['member']) {
                              if (memberId != currentUser!.uid) {
                                return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Users')
                                      .where('uid', isEqualTo: memberId)
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
                                    var data = snapshot.data!.docs;
                                    if (data.isNotEmpty) {
                                      for (var user in data) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              isSelected = !isSelected;
                                            });
                                            isSelected
                                                ? checkList.add(
                                                    userList[index]['chatid'])
                                                : checkList.remove(
                                                    userList[index]['chatid']);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                isSelected
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right:
                                                                    size.width *
                                                                        0.03),
                                                        child: SvgPicture.asset(
                                                            "assets/icons/check_chatlist.svg"),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right:
                                                                    size.width *
                                                                        0.03),
                                                        child: SvgPicture.asset(
                                                            "assets/icons/uncheck_chatlist.svg"),
                                                      ),
                                                Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: !user[
                                                                  'profilePic']
                                                              .isEmpty
                                                          ? NetworkImage(
                                                              user['profilePic']
                                                                  [0])
                                                          : const AssetImage(
                                                                  "assets/images/header_img1.png")
                                                              as ImageProvider,
                                                      radius: 33,
                                                    ),
                                                    user['isActive'] == true &&
                                                            user['isShowActive'] ==
                                                                true &&
                                                            snapshot.data!
                                                                        .docs[0]
                                                                    [
                                                                    'isShowActive'] ==
                                                                true
                                                        ? Positioned(
                                                            right: 3,
                                                            bottom: 3,
                                                            child: Container(
                                                              height: 16,
                                                              width: 16,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      onlineColor,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor)),
                                                            ),
                                                          )
                                                        : const Text(''),
                                                  ],
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.width *
                                                                      0.05),
                                                      child: Text(
                                                        user['name'][
                                                                    'firstname']
                                                                .toString() +
                                                            ' ' +
                                                            user['name']
                                                                    ['lastname']
                                                                .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: textDark,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.width *
                                                                      0.05),
                                                      child: Text(
                                                        userList[index][
                                                                'lastMessageSent']
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: greyDark,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                                Text(
                                                  // chat['lastTimestamp']
                                                  getDate(userList[index]
                                                      ['lastTimestamp']),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: greyDark),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                    return const Text('');
                                  },
                                );
                              }
                            }
                          }
                          return const Text('Let\'s exchange with the expert!');
                        },
                      );
                    },
                  );
                },
              );
            },
          )),
          // Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButtonComponent(
                  // Todo: unpair
                  text: "MenuUnmatch".tr,
                  minimumSize: Size(size.width * 0.45, size.height * 0.05),
                  press: () {
                    unMatch();
                  }),
              RoundButton(
                  // Todo: del chat
                  text: "DeleteConversation".tr,
                  minimumSize: Size(size.width * 0.45, size.height * 0.05),
                  press: () {
                    removeChat();
                  })
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          )
        ],
      ),
    );
  }
}
