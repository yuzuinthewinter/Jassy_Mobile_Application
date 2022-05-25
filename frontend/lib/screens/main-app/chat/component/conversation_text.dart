import 'package:another_flushbar/flushbar.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controllers/reply.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

class ConversationText extends StatefulWidget {
  final chatid;
  final user;
  final inRoom;

  const ConversationText({
    Key? key,
    required this.user,
    required this.chatid,
    required this.inRoom,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<ConversationText> {
  CollectionReference chats =
      FirebaseFirestore.instance.collection('ChatRooms');
  CollectionReference messagesdb =
      FirebaseFirestore.instance.collection('Messages');
  CollectionReference memos =
      FirebaseFirestore.instance.collection('MemoMessages');
  var currentUser = FirebaseAuth.instance.currentUser;

  final _LanguageChoicesLists = [
    'Cambodian',
    'English',
    'Indonesian',
    'Japanese',
    'Korean',
    'Thai',
  ];
  ReplyController replyController = Get.put(ReplyController());
  bool _isReply = false;
  String _message = '';
  String _chatid = '';
  String _type = 'text';
  int count = -1;
  bool _isTranslate = false;

  getTime(timestamp) {
    DateTime datatime = DateTime.parse(timestamp.toDate().toString());
    String formattedTime = DateFormat('KK:mm a').format(datatime);
    return formattedTime.toString();
  }

  checkReadMessage(messageid) async {
    await messagesdb.doc(messageid).update({
      'status': 'read',
    });
  }

  updateCountMessage(messageid) async {
    await chats.doc(widget.chatid).update({
      'unseenCount': count,
    });
  }

  AddFavorite(messageid, languageName) async {
    var languageHeader = languageName.toLowerCase();
    var queryFav = memos.where('owner', isEqualTo: currentUser!.uid);
    QuerySnapshot querySnapshot = await queryFav.get();
    if (querySnapshot.docs.isNotEmpty) {
      await memos.doc(currentUser!.uid).update({
        'owner': currentUser!.uid,
        'pingroup': [],
        'listLanguage': FieldValue.arrayUnion([languageHeader]),
        '$languageHeader': FieldValue.arrayUnion([messageid]),
      });
    } else {
      await memos.doc(currentUser!.uid).set({
        'owner': currentUser!.uid,
        'pingroup': [],
        'listLanguage': FieldValue.arrayUnion([languageHeader]),
        '$languageHeader': FieldValue.arrayUnion([messageid]),
      });
    }
    Navigator.of(context).pop();
  }

  replyMessage(message) {
    _isReply = true;
    _chatid = widget.chatid;
    replyController.updateReply(message['message'], _isReply, _chatid, _type);
  }

  @override
  void initState() {
    _isReply = replyController.isReply.value;
    _message = replyController.message.value.toString();
    _chatid = replyController.chatid.value.toString();
    _type = replyController.type.value.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.12,
                ),
                CircleAvatar(
                  radius: 42,
                  backgroundImage: !widget.user['profilePic'].isEmpty
                      ? NetworkImage(widget.user['profilePic'][0])
                      : const AssetImage("assets/images/header_img1.png")
                          as ImageProvider,
                ),
                Text(
                  '${StringUtils.capitalize(widget.user['name']['firstname'])} ${StringUtils.capitalize(widget.user['name']['lastname'])}',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'want to share their language with you',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "kanit",
                      fontWeight: FontWeight.w700,
                      color: greyDarker,
                    ),
                    children: [
                      TextSpan(
                          text:
                              '${widget.user['language']['defaultLanguage']} '),
                      const WidgetSpan(
                          child: Icon(
                        Icons.sync_alt,
                        size: 20,
                        color: greyDark,
                      )),
                      TextSpan(
                          text:
                              ' ${widget.user['language']['interestedLanguage']}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.docs[0]['messages'].length,
          itemBuilder: (context, index) {
            int reversedIndex =
                snapshot.data!.docs[0]['messages'].length - 1 - index;
            CustomPopupMenuController _controller = CustomPopupMenuController();            
            return getMessage(snapshot.data!.docs[0]['messages'][reversedIndex],
                widget.user['isActive'], _controller);
          },
        );
      },
    );
  }

  Widget getMessage(message, userActive, _controller) {
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
        if (currentMessage['status'] == 'unread' &&
            widget.inRoom == true &&
            currentMessage['sentBy'] != currentUser!.uid) {
          checkReadMessage(currentMessage['messageID']);
        }
        if (currentMessage['status'] == 'unread') {
          count = count + 1;
        }
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
                            currentMessage['status'] == 'read'
                                ? Text(
                                    "ChatRead".tr,
                                    style: TextStyle(color: grey, fontSize: 12),
                                    textAlign: TextAlign.right,
                                  )
                                : const Text(''),
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
                    menuBuilder: () {
                      return _buildLongPressMenu(currentMessage, _controller);
                    },
                    controller: _controller,
                    pressType: PressType.longPress,
                    arrowColor: primaryDarker,
                    child: Column(
                        crossAxisAlignment: isCurrentUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          currentMessage['isReplyMessage'] == true
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.02),
                                      child: SvgPicture.asset(
                                          "assets/icons/reply-fill.svg"),
                                    ),
                                    Text(
                                      "Reply".tr + " : ",
                                      style: TextStyle(
                                          color: greyDark, fontSize: 12),
                                    ),
                                    currentMessage['type'] == 'text'
                                        ? Container(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6),
                                            child: Text(
                                              currentMessage[
                                                  'replyFromMessage'],
                                              style: TextStyle(
                                                  color: greyDark,
                                                  fontSize: 12),
                                              maxLines: null,
                                              textAlign: TextAlign.left,
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : currentMessage['type'] == 'image'
                                            ? Image.network(
                                                currentMessage['url'],
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                fit: BoxFit.contain,
                                              )
                                            : const Text(
                                                'File',
                                                style: TextStyle(
                                                    color: greyDark,
                                                    fontSize: 14),
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          currentMessage['type'] == 'text'
                              ? TypeTextMessage(
                                  isCurrentUser: isCurrentUser,
                                  currentMessage: currentMessage,
                                  translate: _isTranslate,)
                              : currentMessage['type'] == 'image'
                                  ? TypeImageMessage(
                                      isCurrentUser: isCurrentUser,
                                      currentMessage: currentMessage)
                                  : TypeFileMessage(
                                      isCurrentUser: isCurrentUser,
                                      currentMessage: currentMessage),
                        ]),
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

  Widget _buildLongPressMenu(message, _controller) {
    List<ItemModel> menuItems = [
      ItemModel(id: 1, text: "Reply".tr, icon: "assets/icons/reply_icon.svg"),
      ItemModel(id: 2, text: "Copy".tr, icon: "assets/icons/copy_icon.svg"),
      ItemModel(
          id: 3, text: "Translate".tr, icon: "assets/icons/translate_icon.svg"),
      ItemModel(id: 4, text: "Like".tr, icon: "assets/icons/favorite_icon.svg"),
    ];
    var item1 = menuItems[0].id;
    var item2 = menuItems[1].id;
    var item3 = menuItems[2].id;
    var item4 = menuItems[3].id;

    Size size = MediaQuery.of(context).size;
    bool isDismiss = true;
    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * 0.65,
        maxHeight: size.height * 0.08,
      ),
      decoration: const BoxDecoration(
        color: primaryDarker,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: GridView.count(
        padding: const EdgeInsets.symmetric(vertical: 0),
        crossAxisCount: 4,
        children: menuItems
            .map((item) => Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(color: textLight, width: 0.1))),
                  child: InkWell(
                    onTap: () {
                      // Todo: add onTab here
                      _controller.hideMenu();
                      if (item.id == item1) {
                        replyMessage(message);
                        print('reply');
                      } else if (item.id == item2) {
                        //copy
                        Clipboard.setData(
                            ClipboardData(text: message['message']));
                      } else if (item.id == item3) {
                        Flushbar(
                          title: 'Title',
                          message: 'messageeeeee',
                          backgroundColor: primaryDarker,
                          duration: null,
                        ).show(context);
                        //translate
                        // setState(() {
                        //   _isTranslate = !_isTranslate;
                        // });
                        print("translate");
                      } else {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.05,
                                    vertical: size.height * 0.02),
                                height: size.height * 0.3,
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: primaryDark,
                                            ))),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.03),
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: _LanguageChoicesLists.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                AddFavorite(
                                                    message['messageID'],
                                                    _LanguageChoicesLists[
                                                        index]);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.05,
                                                    vertical:
                                                        size.height * 0.015),
                                                child: Text(
                                                    _LanguageChoicesLists[
                                                        index]),
                                              ));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(item.icon),
                        Text(
                          item.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
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

class TypeTextMessage extends StatelessWidget {
  const TypeTextMessage({
    Key? key,
    required this.isCurrentUser,
    required this.currentMessage,
    required this.translate
  }) : super(key: key);

  final bool isCurrentUser;
  final bool translate;
  final currentMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: isCurrentUser ? primaryLighter : textLight,
          borderRadius: BorderRadius.circular(20)),
      child: 
      // Column(
      //   children: [
          // isCurrentUser == false ? translate ? Text(currentMessage['message']) : SizedBox.shrink() : SizedBox.shrink(),
          // isCurrentUser == false ? translate ? const Divider(
          //   thickness: 2,
          //   color: greyLight,
          // ) : SizedBox.shrink() : SizedBox.shrink(),
          Text(currentMessage['message']),
        // ],
      // ),
    );
  }
}

class TypeTextTranslate extends StatelessWidget {
  const TypeTextTranslate({
    Key? key,
    required this.isCurrentUser,
    required this.currentMessage,
  }) : super(key: key);

  final bool isCurrentUser;
  final currentMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: isCurrentUser ? primaryLighter : textLight,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text("currentMessage['message']sssssssssssssssssssssssssssssssssssssssssssss"),
          Divider(
            thickness: 2,
            color: greyLight,
          ),
          Text(currentMessage['message']),
        ],
      ),
    );
  }
}

class TypeFileMessage extends StatelessWidget {
  const TypeFileMessage({
    Key? key,
    required this.isCurrentUser,
    required this.currentMessage,
  }) : super(key: key);

  final bool isCurrentUser;
  final currentMessage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Todo: open file
      },
      child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
            maxHeight: MediaQuery.of(context).size.width * 0.4,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: isCurrentUser ? primaryLighter : textLight,
              borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.01),
                child: Icon(
                  Icons.description,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: Text("file.pdf"),
              ),
            ],
          )),
    );
  }
}

class TypeImageMessage extends StatelessWidget {
  const TypeImageMessage({
    Key? key,
    required this.isCurrentUser,
    required this.currentMessage,
  }) : super(key: key);

  final bool isCurrentUser;
  final currentMessage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushTransparentRoute(InteractiveViewer(
          child: ImageMessageDetail(
              isCurrentUser: isCurrentUser, currentMessage: currentMessage),
        ));
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.4,
          maxHeight: MediaQuery.of(context).size.width * 0.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: currentMessage['url'].isNotEmpty
                    ? NetworkImage(currentMessage['url'])
                    : const AssetImage("assets/images/chat_message.jpg")
                        as ImageProvider,
                fit: BoxFit.cover)),
      ),
    );
  }
}

class ImageMessageDetail extends StatelessWidget {
  const ImageMessageDetail({
    Key? key,
    required this.isCurrentUser,
    required this.currentMessage,
  }) : super(key: key);

  final bool isCurrentUser;
  final currentMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.multi,
      child: currentMessage['url'].isNotEmpty
          ? Image.network(
              currentMessage['url'],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            )
          : Image.asset(
              "assets/images/chat_message.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            ),
    ));
  }
}
