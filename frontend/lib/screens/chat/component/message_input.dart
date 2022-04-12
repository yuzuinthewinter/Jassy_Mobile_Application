import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor
      ),
        child: Row(
          children: [
            InkWell(
              // TODO: add add icon detail (ammie)
              onTap: () {
                print("add icon");
              },
              child: SvgPicture.asset("assets/icons/add_circle.svg")
            ),
            SizedBox(width: size.height * 0.01,),
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "พิมพ์ข้อความ",
                  suffixIcon: InkWell(
                    // TODO : add emoji picker (ammie)
                    onTap: () {
                      print("emoji");
                    },
                    child: Icon(Icons.sentiment_satisfied_alt, color: primaryColor,)
                  ),
                  filled: true,
                  fillColor: textLight,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: primaryLighter, width: 0.0)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide:  const BorderSide(color: primaryLighter ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide:  const BorderSide(color: primaryLighter ),
                  ),
                ),
              )
            ),
            SizedBox(width: size.height * 0.02,),
            InkWell(
              onTap: () {
                print("send");
              },
              child: SvgPicture.asset("assets/icons/send.svg")
            )
          ],
        )
    );
  }
}