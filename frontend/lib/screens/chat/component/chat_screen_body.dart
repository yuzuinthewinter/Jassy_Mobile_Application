import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({ Key? key }) : super(key: key);

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CurvedWidget(
            child: JassyGradientColor()
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: TextFormField(
                // controller: passwordController,
                // obscureText: isHiddenPassword, 
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  // suffixIcon: InkWell(
                  //   onTap: _togglePasswordView,
                  //   child: isHiddenPassword? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                  // ),
                  prefixIcon: SvgPicture.asset('assets/icons/search.svg', height: 16,),
                  fillColor: textLight,
                  hintText: "ค้นหา",
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: textLight, width: 0.0)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide:  const BorderSide(color: textLight ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide:  const BorderSide(color: textLight ),
                  ),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty){
                //     return "enter some text";
                //   } else if (!regex.hasMatch(value)) {
                //     return "กรุณากรอกตามpattern";
                //   } return null;
                // },
                // onSaved: (String? password) {
                //   user.password = password!;
                // },
            ),
          ),
          Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(chat: chatsData[index],)
          )
          )
        ],
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key, 
    required this.chat
  }) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(chat.image),
            radius: 33,
          ),
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              color: onlineColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(text: chat.name),
                DescriptionText(text: chat.lastMessage,)
              ],
            )
          ),
        Text(chat.time, style: TextStyle(fontSize: 12, color: greyDark),)
        ],
      ),
    );
  }
}