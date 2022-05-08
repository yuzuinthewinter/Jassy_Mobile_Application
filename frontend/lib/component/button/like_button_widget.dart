import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  const LikeButtonWidget({ Key? key }) : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  bool isLike = false;
  int likeCount = 10;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LikeButton(
      size: size.width * 0.07,
      // likeBuilder: (isLike) {
      //   final color = isLike ? Colors.red : Colors.grey;
      //   return Icon(Icons.favorite, color: color,);
      // },
      // countBuilder: (count, isLike, text) {

      // },
      isLiked: isLike,
      likeCount: likeCount,
      onTap: (isLike) async{
        this.isLike = !isLike;
        likeCount += this.isLike ? 1 : -1;
        print(!isLike);
        return !isLike;
      },
    );
  }
}