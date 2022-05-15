import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

class ConversationText extends StatefulWidget {
  final chatid;
  final user;

  const ConversationText({
    Key? key,
    required this.user,
    required this.chatid,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<ConversationText> {
  CollectionReference chats =
      FirebaseFirestore.instance.collection('ChatRooms');
  CollectionReference messagesdb =
      FirebaseFirestore.instance.collection('Messages');
  var currentUser = FirebaseAuth.instance.currentUser;

  getTime(timestamp) {
    DateTime datatime = DateTime.parse(timestamp.toDate().toString());
    String formattedTime = DateFormat('KK:mm:a').format(datatime);
    return formattedTime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chats
          .where('chatid', isEqualTo: widget.chatid)
          .snapshots(includeMetadataChanges: true),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        var data = snapshot.data!.docs;
        if (data.isEmpty) {
          return Center(child: Text(data.toString()));
        }
        if (data[0]['messages'].isEmpty) {
          return const Center(child: Text('Let\'s start conversation'));
        }
        return ListView.builder(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.docs[0]['messages'].length,
          itemBuilder: (context, index) {
            int reversedIndex =
                snapshot.data!.docs[0]['messages'].length - 1 - index;
            return getMessage(
                snapshot.data!.docs[0]['messages'][reversedIndex]);
          },
        );
      },
    );
  }

  Widget getMessage(message) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: messagesdb
          .where('messageID', isEqualTo: message)
          .snapshots(includeMetadataChanges: true),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text(' '));
        }
        List<dynamic> snap = snapshot.data!.docs;
        var currentMessage = snap[0];
        var sender = currentMessage['sentBy'];
        bool isCurrentUser = sender == currentUser!.uid;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: isCurrentUser
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      if (!isCurrentUser) ...[
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: !widget.user['profilePic'].isEmpty
                              ? NetworkImage(widget.user['profilePic'][0])
                              : const AssetImage(
                                      "assets/images/header_img1.png")
                                  as ImageProvider,
                        ),
                        SizedBox(
                          width: size.height * 0.06,
                        ),
                      ],
                      if (isCurrentUser) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "ChatRead".tr,
                              style: TextStyle(color: grey, fontSize: 12),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              getTime(currentMessage['time']).toString(),
                              style: const TextStyle(color: grey, fontSize: 12),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.height * 0.07,
                        ),
                      ]
                    ],
                  ),
                  CustomPopupMenu(
                    menuBuilder: _buildLongPressMenu, 
                    pressType: PressType.longPress,
                    arrowColor: primaryDarker,
                    child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: isCurrentUser ? primaryLighter : textLight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(currentMessage['message'])
                    ),
                  ),
                  if (!isCurrentUser) ...[
                    Text(
                      getTime(currentMessage['time']).toString(),
                      style: const TextStyle(color: grey, fontSize: 12),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

 Widget _buildLongPressMenu() {
    List<ItemModel> menuItems = [
      ItemModel(id: 1, text: "ตอบกลับ", icon: "assets/icons/reply_icon.svg"),
      ItemModel(id: 2, text: "คัดลอก", icon: "assets/icons/copy_icon.svg"),
      ItemModel(id: 3, text: "แปล", icon: "assets/icons/translate_icon.svg"),
      ItemModel(id: 4, text: "ชอบ", icon: "assets/icons/favorite_icon.svg"),
    ];
    var item1 = menuItems[0].id;
    var item2 = menuItems[1].id;
    var item3 = menuItems[2].id;
    var item4 = menuItems[3].id;

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      height: size.height * 0.08,
      decoration: const BoxDecoration(
        color: primaryDarker,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: GridView.count(
        padding: const EdgeInsets.symmetric(vertical: 0),
          crossAxisCount: 4,     
          children: menuItems
            .map((item) => 
            Container(
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: textLight, width: 0.1))
              ),
              child: InkWell(
                onTap: () {
                  // Todo: add onTab here
                  if(item.id == item1) {
                    return print("reply");
                  } else if (item.id == item2) {
                    return print("copy");
                  } else if (item.id == item3) {
                    return print("translate");
                  } else {
                    print("favorite");
                  }
                },
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(item.icon),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            item.text,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
              ),
            ))
            .toList(),
        ),
    );
  }
}
