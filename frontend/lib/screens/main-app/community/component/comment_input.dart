import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentInput extends StatefulWidget {
  final Size size;
  final Widget child;

  const CommentInput({
    Key? key,
    required this.size, 
    required this.child, 
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<CommentInput> {

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
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Row(
          children: [
            InkWell(
                // TODO: add add icon detail (ammie)
                onTap: () {},
                child: SvgPicture.asset("assets/icons/add_circle.svg")),
            SizedBox(
              width: widget.size.height * 0.01,
            ),
            Expanded(
              child: widget.child
            ),
            SizedBox(
              width: widget.size.height * 0.02,
            ),
            InkWell(
                onTap: () {},
                child: SvgPicture.asset("assets/icons/send.svg"))
          ],
        ));
  }
}