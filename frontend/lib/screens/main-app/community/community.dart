import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/community_appbar.dart';
import 'package:flutter_application_1/screens/main-app/community/component/community_body.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
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
          var user = snapshot.data!.docs[0];
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Community')
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
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text(''));
                }
                var data = snapshot.data!.docs;
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: CommunityAppBar(
                    user: user,
                    group: data,
                    text: user['userStatus'] == 'user'
                        ? "ชุมชน"
                        : "การจัดการชุมชน",
                  ),
                  body: CommunityScreenBody(user, data),
                );
              });
        });
  }
}
