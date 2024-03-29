import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/controllers/reply.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/conversation_text.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/message_input.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class MessageScreenBody extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final chatid;
  final user;
  final currentUser;
  final inRoom;

  const MessageScreenBody(
      {Key? key,
      required this.chatid,
      required this.user,
      required this.currentUser,
      required this.inRoom})
      : super(key: key);

  @override
  State<MessageScreenBody> createState() => _MessageScreenBodyState();
}

class _MessageScreenBodyState extends State<MessageScreenBody> {
  CollectionReference chats =
      FirebaseFirestore.instance.collection('ChatRooms');

  updateUnseen() async {
    await chats.doc(widget.chatid).update({
      'unseenCount': 0,
    });
  }

  @override
  void initState() {
    if (widget.inRoom == true) {
      updateUnseen();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
        // Text(widget.chatid.toString());
        GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          JassyGradientColor(gradientHeight: 90,),
          Expanded(
            child: ConversationText(
              user: widget.user,
              currentUser: widget.currentUser,
              chatid: widget.chatid,
              inRoom: widget.inRoom,
            ),
          ),
          widget.user['report'].length < 5 || widget.user['userStatus'] != 'blocked'
              ? MessageInput(
                  size: size, chatid: widget.chatid)
              : Center(
                  heightFactor: 5,
                  child: Text(
                    'ChatShowReport'.tr,
                    style: TextStyle(color: greyDark),
                  ))
        ],
      ),
    );
  }
}

// อันเก่าเดี๋ยวค่อยลบเผื่อใช้
// อันเก่าดี๋ยวค่อยลบเผื่อใช้
// class MessageScreenBody extends StatelessWidget {
//   const MessageScreenBody({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Column(
//             children: [
//               // CurvedWidget(
//               //   child: JassyGradientColor()
//               // ),
//               Expanded(
//                 child: ListView.builder(
//                   reverse: true,
//                   physics: BouncingScrollPhysics(),
//                   itemCount: demoChatMessages.length,
//                   itemBuilder: (context, index) {
//                     final message = demoChatMessages[index];
//                     bool isMe = message.sender.id == currentUser.id;
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//                         children: [
//                            if (!isMe) ...[
//                               CircleAvatar(radius: 20, backgroundImage: AssetImage(widget.user.image),),
//                               SizedBox(width: size.height * 0.01,),
//                             ],
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             decoration: BoxDecoration(
//                               color: isMe ? primaryLighter : textLight,
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                             child: Text(demoChatMessages[index].text)
//                           ),
//                         ],
//                       ),
//                     );
//                   },)
//               ),
//               MessageInput(size: size)
//             ],
//           ),
//     );
//   }
// }

// Note: Message input = ช่อง input at bottom


// class Message extends StatelessWidget {

//   final ChatMessage message;

//   const Message({
//     Key? key,
//     required this.message
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!message.isSender) ...[
//             CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/images/header_img1.png'),),
//             SizedBox(width: size.height * 0.01,),
//           ],
//           TextMessage(size: size, message: message),
//         ],
//       ),
//     );
//   }
// }

// class TextMessage extends StatelessWidget {
//   const TextMessage({
//     Key? key,
//     required this.size,
//     required this.message,
//   }) : super(key: key);

//   final Size size;
//   final ChatMessage message;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(message.text),
//       // margin: EdgeInsets.only(top: size.height * 0.02),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: message.isSender ? primaryLighter : textLight,
//         borderRadius: BorderRadius.circular(20)
//       ),
//     );
//   }
// }