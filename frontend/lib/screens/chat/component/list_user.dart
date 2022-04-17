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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * 0.18,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listUser.length,
            itemBuilder: (context, int index) => listUser[index].isActive
                ? InkWell(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                        // NOTE: click each card to go to chat room
                        return ChatRoom(
                          user: listUser[index],
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
                                backgroundImage:
                                    AssetImage(listUser[index].image),
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
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 70.0,
                            child: Text(
                              listUser[index].name,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ))
                : Container()),
      ),
    );
  }
}
