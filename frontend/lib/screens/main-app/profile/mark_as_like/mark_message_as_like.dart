import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/mark_message_as_like_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarkMessageAsLike extends StatefulWidget {
  const MarkMessageAsLike({ Key? key }) : super(key: key);

  @override
  State<MarkMessageAsLike> createState() => _MarkMessageAsLikeState();
}

List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];


class _MarkMessageAsLikeState extends State<MarkMessageAsLike> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MarkMessageAsLikeAppBar(
        actionWidget: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.check_circle_outline_rounded),
          color: primaryDarker,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02, left: size.height * 0.02, right: size.height * 0.02),
                    child: const Text("รายการที่ปักหมุดไว้", style: TextStyle(fontSize: 20, color: greyDark),),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: size.width / size.height / 0.35,
                          crossAxisCount: 2,
                          crossAxisSpacing: size.height * 0.02,
                          mainAxisSpacing: size.height * 0.02,
                        ),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(size.height * 0.015),
                            color: colors[index % colors.length],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset("assets/icons/pin.svg"),
                                    SizedBox(width: size.width * 0.01),
                                    const Icon(Icons.more_horiz, color: primaryDarker,),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.01),
                                // Todo: add pin like text
                                const Text(
                                  "ยืมมาจากภาษาบาลีภาษาสันสกฤต และ",
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 2, 
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: size.height * 0.02),
                    child: const Text("December 2021", style: TextStyle(fontSize: 20, color: greyDark),),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: size.width / size.height / 0.35,
                          crossAxisCount: 2,
                          crossAxisSpacing: size.height * 0.02,
                          mainAxisSpacing: size.height * 0.02
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(size.height * 0.015),
                            color: colors[index % colors.length],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.more_horiz, color: primaryDarker,)
                                ),
                                SizedBox(height: size.height * 0.01),
                                // Todo: add like text
                                const Text(
                                  "ยืมมาจากภาษาบาลีภาษาสันสกฤต และ",
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 2, 
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          );
                        }
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}