import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/component/comment_input.dart';
import 'package:flutter_application_1/screens/main-app/community/component/comment_tree.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostDetailBody extends StatefulWidget {
  final News post;
  const PostDetailBody({ 
    Key? key, 
    required this.post 
    }) : super(key: key);

  @override
  State<PostDetailBody> createState() => _PostDetailBodyState();
}

class _PostDetailBodyState extends State<PostDetailBody> {
  TextEditingController messageController = TextEditingController();
  late FocusNode myFocusNode;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        CurvedWidget(child: JassyGradientColor(gradientHeight: size.height * 0.23,)),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // writer avatar
                      CircleAvatar(
                        backgroundImage: const AssetImage("assets/images/user3.jpg"),
                        radius: size.width * 0.07,
                      ),
                      // writer name and post date
                      // Todo: change date format
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.post.writer, style: const TextStyle(fontSize: 18),),
                              SizedBox(height: size.height * 0.008,),
                              Text(widget.post.date.toString().substring(0,10), style: const TextStyle(color: greyDark),),
                            ],
                          ),
                        ),
                      ),
                      Icon(Icons.more_horiz, color: primaryColor, size: size.width * 0.08,)
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                // post text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: double.infinity),
                    child: Text(widget.post.news, maxLines: null, style: TextStyle(fontSize: 18),),
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                // like and comment icon
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Row(
                    children: [
                      const LikeButtonWidget(),
                      SizedBox(width: size.width * 0.05),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(myFocusNode);
                        },
                        child: SvgPicture.asset("assets/icons/comment_icon.svg", width: size.width * 0.07,)
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(child: JassyCommentTree()),
              ],
            ),
          ),
        ),
        CommentInput(size: size, child: Input(myFocusNode: myFocusNode)),
      ],
    );
  }
}

// input text with nodefocus
class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.myFocusNode,
  }) : super(key: key);

  final FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: messageController,
      focusNode: myFocusNode,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: "เขียนคอมเมนต์",
        suffixIcon: InkWell(
            // TODO : add emoji picker (ammie)
            onTap: () {
              print("emoji");
            },
            child: const Icon(
              Icons.sentiment_satisfied_alt,
              color: primaryColor,
            )),
        filled: true,
        fillColor: textLight,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(color: primaryLighter, width: 0.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: primaryLighter),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: primaryLighter),
        ),
      ),
    );
  }
}