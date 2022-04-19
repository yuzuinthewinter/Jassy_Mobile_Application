import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBody();
}

class _ProfileScreenBody extends State<ProfileScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;

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
              var docs = snapshot.data?.docs;
              final user = docs![0].data()!;
              return Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(user.toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
