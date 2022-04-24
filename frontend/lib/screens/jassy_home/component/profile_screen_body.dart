import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/constants/routes.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBody();
}

class _ProfileScreenBody extends State<ProfileScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('uid', isEqualTo: currentUser!.uid)
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              var user = snapshot.data!.docs;
              if (user.isEmpty) {
                return const Text('Please field your infomation!');
              } else {
                return Text(user[0]['name']['firstname'].toString() +
                    ' ' +
                    user[0]['name']['lastname'].toString());
              }
            },
          ),
        ),
        RoundButton(
          text: 'Sign Out',
          minimumSize: Size(size.width * 0.8, size.height * 0.05),
          press: () async {
            final FirebaseAuth _auth = FirebaseAuth.instance;
            await _auth.signOut();
            Navigator.pushNamed(context, Routes.LandingPage);
          },
        )
      ],
    );
  }
}
