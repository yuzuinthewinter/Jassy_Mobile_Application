import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/back_and_delete_appbar.dart';
import 'package:flutter_application_1/component/popup_page/delete_popup.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/theme/index.dart';

class MessageAsLikeDetail extends StatefulWidget {
  final int color;
  final FavMassage data;
  const MessageAsLikeDetail({ Key? key, required this.color, required this.data }) : super(key: key);

  @override
  State<MessageAsLikeDetail> createState() => _MessageAsLikeDetailState();
}

class _MessageAsLikeDetailState extends State<MessageAsLikeDetail> {
  @override
  Widget build(BuildContext context) {
    List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAndDeleteAppBar(
        color: colors[widget.color],
        delete: () {
          // Todo: delete item
          showDialog(
            context: context, 
            builder: (context) {
              return DeleteWarningPopUp(
                onPress: () {}
              );
            }
          );
        }
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        width: double.infinity,
        color: colors[widget.color],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.data.text, style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}