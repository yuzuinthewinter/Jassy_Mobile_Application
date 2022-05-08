import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/post_detail_appbar.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/component/post_detail_body.dart';

class PostDetail extends StatelessWidget {
  final News post;
  const PostDetail({ Key? key, required this.post }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PostDetailAppBar(post: post,),
      body: PostDetailBody(post: post),
    );
  }
}