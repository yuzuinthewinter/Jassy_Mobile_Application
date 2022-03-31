import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/demo_chat_message.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class MessageScreenBody extends StatefulWidget {
//   const MessageScreenBody({ Key? key, required this.user }) : super(key: key);

//   @override
//   State<MessageScreenBody> createState() => _MessageScreenBodyState();
//   final ChatUser user;
// }

// class _MessageScreenBodyState extends State<MessageScreenBody> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//           children: [
//             // CurvedWidget(
//             //   child: JassyGradientColor()
//             // ),
//             Expanded(
//               child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemCount: demeChatMessages.length,
//                 itemBuilder: (context, index) => Message(message: demeChatMessages[index],)
//               )
//             ),
//             MessageInput(size: size)
//           ],
//         );
//   }
// }
class MessageScreenBody extends StatelessWidget {
  const MessageScreenBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
          children: [
            // CurvedWidget(
            //   child: JassyGradientColor()
            // ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: demeChatMessages.length,
                itemBuilder: (context, index) => Message(message: demeChatMessages[index],)
              )
            ),
            MessageInput(size: size)
          ],
        );
  }
}

class MessageInput extends StatelessWidget {
  const MessageInput({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor
      ),
        child: Row(
          children: [
            SvgPicture.asset("assets/icons/add_circle.svg"),
            SizedBox(width: size.height * 0.01,),
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "พิมพ์ข้อความ",
                  suffixIcon: Icon(Icons.sentiment_satisfied_alt, color: primaryColor,),
                  filled: true,
                  fillColor: textLight,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: primaryLighter, width: 0.0)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide:  const BorderSide(color: primaryLighter ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide:  const BorderSide(color: primaryLighter ),
                  ),
                ),
              )
            ),
            SizedBox(width: size.height * 0.02,),
            SvgPicture.asset("assets/icons/send.svg")
          ],
        )
    );
  }
}

class Message extends StatelessWidget {

  final ChatMessage message;

  const Message({
    Key? key,
    required this.message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/images/header_img1.png'),),
            SizedBox(width: size.height * 0.01,),
          ],
          TextMessage(size: size, message: message),
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.size,
    required this.message,
  }) : super(key: key);

  final Size size;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message.text),
      // margin: EdgeInsets.only(top: size.height * 0.02),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: message.isSender ? primaryLighter : textLight,
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }
}