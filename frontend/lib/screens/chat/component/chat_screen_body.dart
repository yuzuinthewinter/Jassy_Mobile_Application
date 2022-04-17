import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/demo_chat_message.dart';
import 'package:flutter_application_1/screens/chat/component/chat_card.dart';
import 'package:flutter_application_1/screens/chat/component/list_user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({Key? key}) : super(key: key);

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          child: TextFormField(
            // controller: passwordController,
            // obscureText: isHiddenPassword,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                'assets/icons/search.svg',
                height: 16,
              ),
              hintText: 'ค้นหา',
              filled: true,
              fillColor: textLight,
              // contentPadding:
              //     const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
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
        ListUser(),
        Expanded(
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                //TODO: padding vertical = 20.0
                itemCount: recentChats.length,
                itemBuilder: (context, int index) => ChatCard(
                      chat: recentChats[index],
                    )))
      ],
    );
  }
}
