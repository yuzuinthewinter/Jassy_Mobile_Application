import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/main-app/chat/message_screen.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
// TODO: map profile image, name and lastest message here
class EditChatListCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final chatid;
  final currentUser;
  final ValueChanged<bool> isSelected;
  final Key listkey;

  const EditChatListCard({
    Key? key,
    required this.chatid,
    required this.currentUser, 
    required this.isSelected, 
    required this.listkey,
  }) : super(key: key);

  @override
  State<EditChatListCard> createState() => _EditChatListCardBody();
}

class _EditChatListCardBody extends State<EditChatListCard> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection('ChatRooms');

  getDate(timestamp) {
    DateTime datatime = DateTime.parse(timestamp.toDate().toString());
    String formattedTime = DateFormat('KK:mm:a').format(datatime);
    return formattedTime.toString();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isSelected = false;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ChatRooms')
          .where('chatid', isEqualTo: widget.chatid)
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
        var chat = snapshot.data!.docs[0];
        if (chat['member'].length >= 1) {
          for (var memberId in chat['member']) {
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(''),
                    );
                  }
                  var data = snapshot.data!.docs;
                  if (data.isNotEmpty) {
                    for (var user in data) {
                      return InkWell(
                        onTap: () {
                          print(isSelected);
                          setState(() {
                            isSelected = !isSelected;
                            widget.isSelected(isSelected);
                          });
                          print(isSelected);
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                isSelected 
                                ? Padding(
                                  padding: EdgeInsets.only(right: size.width * 0.03),
                                  child: SvgPicture.asset("assets/icons/uncheck_chatlist.svg"),
                                )
                                : Padding(
                                  padding: EdgeInsets.only(right: size.width * 0.03),
                                  child: SvgPicture.asset("assets/icons/uncheck_chatlist.svg"),
                                ),
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: !user['profilePic'].isEmpty
                                          ? NetworkImage(user['profilePic'][0])
                                          : const AssetImage(
                                                  "assets/images/header_img1.png")
                                              as ImageProvider,
                                      radius: 33,
                                    ),
                                    user['isActive'] == true &&
                                            user['isShowActive'] == true &&
                                            widget.currentUser['isShowActive'] ==
                                                true
                                        ? Positioned(
                                            right: 3,
                                            bottom: 3,
                                            child: Container(
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                  color: onlineColor,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor)),
                                            ),
                                          )
                                        : const Text(''),
                                  ],
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                                      child: Text(
                                        user['name']['firstname'].toString() + ' ' + user['name']['lastname'].toString(),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                        fontSize: 18, 
                                        fontWeight: FontWeight.w500,
                                        color: textDark,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.05),
                                      child: Text(
                                        chat['lastMessageSent'].toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: greyDark,
                                        ),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                )),
                                Text(
                                  // chat['lastTimestamp']
                                  getDate(chat['lastTimestamp']),
                                  style: const TextStyle(
                                      fontSize: 12, color: greyDark),
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
  }
}
