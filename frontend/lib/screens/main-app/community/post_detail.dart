import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/post_detail_appbar.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/component/post_detail_body.dart';

class PostDetail extends StatelessWidget {
  final postid;
  // ignore: prefer_const_constructors_in_immutables
  PostDetail({Key? key, required this.postid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Community')
            .where('postsID', arrayContains: postid)
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
          var group = snapshot.data!.docs[0];
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Posts")
                  .where('postid', isEqualTo: postid)
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
                var post = snapshot.data!.docs[0];
                return Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: PostDetailAppBar(
                      group: group,
                    ),
                    body: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .where('uid', isEqualTo: post['postby'])
                          .snapshots(includeMetadataChanges: true),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text(''));
                        }
                        var queryUser = snapshot.data!.docs[0];
                        return PostDetailBody(post: post, user: queryUser);
                      },
                    ));
              });
        });
  }
}
