import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  final userid;
  final post;
  const LikeButtonWidget(this.post, this.userid, {Key? key}) : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  bool isLike = false;

  CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
  var currentUser = FirebaseAuth.instance.currentUser;

  likeToPost(isLike) async {
    if (isLike == true) {
      await posts.doc(widget.post['postid']).update({
        'likes': FieldValue.arrayUnion([currentUser!.uid]),
      });
    } else {
      await posts.doc(widget.post['postid']).update({
        'likes': FieldValue.arrayRemove([currentUser!.uid]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    for (var userid in widget.post['likes']) {
      if (currentUser!.uid == userid) {
        isLike = true;
      }
    }
    return LikeButton(
      size: size.width * 0.07,
      isLiked: isLike,
      likeCount: widget.post['likes'].length,
      onTap: (isLike) async {
        isLike = !isLike;
        likeToPost(isLike);
        widget.post['likes'].length += this.isLike ? 1 : -1;
        return this.isLike;
      },
    );
  }
}
