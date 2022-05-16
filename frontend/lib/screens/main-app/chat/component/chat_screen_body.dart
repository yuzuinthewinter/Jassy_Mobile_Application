import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/chat_selected_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/edit_chatlist.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({Key? key,}) : super(key: key);

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ChatSelectedAppBar(
        text: "HeaderChatPage".tr,
        action: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditChatList()),
            );
          }, 
          icon: SvgPicture.asset('assets/icons/list_check.svg',), 
          color: primaryDarker,),
      ),
      body: Column(
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
                hintText: 'SearchChat'.tr,
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              //call all chatroom
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where('uid', isEqualTo: currentUser!.uid)
                  .snapshots(includeMetadataChanges: true),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs[0]['chats'].length == 0) {
                  return const Center(child: Text('Let\'s start conversation'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  itemCount: snapshot.data!.docs[0]['chats'].length,
                  itemBuilder: (context, int index) {
                    var data = snapshot.data!.docs[0];
                    var sendSelected = isSelected;
                    return ChatCard(
                      chatid: data['chats'][index],
                      currentUser: data,
                    );
                  },
                );
              },
            )
          )
        ],
      ),
    );
  }
}
