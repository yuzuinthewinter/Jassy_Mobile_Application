import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/demo_chat_message.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';

class ConversationText extends StatelessWidget {
  const ConversationText({
    Key? key,
    required this.user,
  }) : super(key: key);

  final user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      reverse: true,
      physics: BouncingScrollPhysics(),
      itemCount: demoChatMessages.length,
      itemBuilder: (context, index) {
        final message = demoChatMessages[index];
        bool isMe = message.sender.id == currentUser.id;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isMe) ...[
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(user['profilePic'].isEmpty
                          ? "assets/images/header_img1.png"
                          : user['profilePic'][0]),
                    ),
                    SizedBox(
                      width: size.height * 0.01,
                    ),
                  ],
                  if (isMe) ...[
                    // TODO: add isRead?
                    const Text(
                      "อ่านแล้ว",
                      style: TextStyle(color: grey, fontSize: 12),
                    ),
                    SizedBox(
                      width: size.height * 0.01,
                    ),
                  ],
                  Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: isMe ? primaryLighter : textLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(message.text)),
                ],
              ),
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isMe)
                    SizedBox(
                      width: size.height * 0.06,
                    ),
                  Text(
                    message.time,
                    style: TextStyle(color: grey, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
