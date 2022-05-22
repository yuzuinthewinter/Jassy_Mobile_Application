import 'package:basic_utils/basic_utils.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/theme/index.dart';

class JassyCommentTree extends StatefulWidget {
  final post;
  final user;
  const JassyCommentTree(this.post, this.user, { Key? key }) : super(key: key);

  @override
  State<JassyCommentTree> createState() => _JassyCommentTreeState();
}

class _JassyCommentTreeState extends State<JassyCommentTree> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
          child: CommentTreeWidget(
            Comment(
                avatar: 'null',
                userName: 'null',
                content: 'felangel made felangel/cubit_and_beyond public '),
            [
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'A Dart template generator which helps teams'),
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content:
                      'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'A Dart template generator which helps teams'),
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content:
                      'A Dart template generator which helps teams generator which helps teams '),
            ],
            treeThemeData:
                const TreeThemeData(lineColor: grey, lineWidth: 3),
            avatarRoot: (context, data) => const PreferredSize(
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/user4.jpg'),
              ),
              preferredSize: Size.fromRadius(18),
            ),
            contentRoot: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.01),
                    decoration: BoxDecoration(
                        color: greyLightest,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         '${StringUtils.capitalize(widget.user['name']['firstname'])} ${StringUtils.capitalize(widget.user['name']['lastname'])}',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'content',
                          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 14, color: greyDark, fontWeight: FontWeight.bold, fontFamily: 'kanit'),
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.005),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          // const LikeButtonWidget(),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: const Text('Reply')
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          padding: EdgeInsets.symmetric(vertical: size.width * 0.05, horizontal: size.height * 0.01),
        ),
    );
  }
}