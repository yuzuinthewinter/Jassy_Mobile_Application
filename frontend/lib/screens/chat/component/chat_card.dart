import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/demo_chat_message.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/chat/message_screen.dart';
import 'package:flutter_application_1/theme/index.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
// TODO: map profile image, name and lastest message here
class ChatCard extends StatelessWidget {
  final ChatMessage chat;
  // final VoidCallback press;

  const ChatCard({
    Key? key,
    // required this.press,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
          // NOTE: click each card to go to chat room
          return ChatRoom(
            user: chat.sender,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(chat.sender.image),
                  radius: 33,
                ),
                if (chat.sender.isActive)
                  Positioned(
                    right: 3,
                    bottom: 3,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: onlineColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:
                                  Theme.of(context).scaffoldBackgroundColor)),
                    ),
                  ),
              ],
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(text: chat.sender.name),
                DescriptionText(
                  text: chat.lastMessage,
                )
              ],
            )),
            Text(
              chat.time,
              style: TextStyle(fontSize: 12, color: greyDark),
            )
          ],
        ),
      ),
    );
  }
}
