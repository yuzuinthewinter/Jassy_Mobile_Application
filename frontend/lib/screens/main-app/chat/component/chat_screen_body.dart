import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/list_chat.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({Key? key}) : super(key: key);

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;

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
                'assets/icons/search_input.svg',
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
        const Expanded(child: ListChat())
      ],
    );
  }
}
