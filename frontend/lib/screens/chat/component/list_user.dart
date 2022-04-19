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
class ListUser extends StatelessWidget {
  final ChatUser user;
  // final VoidCallback press;

  const ListUser({
    Key? key,
    // required this.press,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) {
            // NOTE: click each card to go to chat room
            return ChatRoom(
              user: user,
            );
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(user.image),
                    radius: 33,
                  ),
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
              SizedBox(
                width: 70.0,
                child: Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
