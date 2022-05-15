import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/mark_message_as_like_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarkMessageAsLike extends StatefulWidget {
  const MarkMessageAsLike({ Key? key }) : super(key: key);

  @override
  State<MarkMessageAsLike> createState() => _MarkMessageAsLikeState();
}

List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
List<ItemModel> menuItems = [
  ItemModel(id: 1, text: "ปักหมุด"),
  ItemModel(id: 2, text: "ลบ"),
];
List<ItemModel> pinMenuItems = [
  ItemModel(id: 1, text: "ยกเลิกการปักหมุด"),
  ItemModel(id: 2, text: "ลบ"),
];

Map<int, CustomPopupMenuController> _pinController = new Map();
Map<int, CustomPopupMenuController> _notPinController = new Map();

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
                        itemCount: test.length,
                        itemBuilder: (context, index) {
                          for (var val in test) {
                            _pinController[val.id] = new CustomPopupMenuController();
                          }
                          var item1 = pinMenuItems[0].id;
                          return InkWell(
                            onTap: () {
                              print("next");
                            },
                            child: Container(
                              padding: EdgeInsets.all(size.height * 0.015),
                              color: colors[index % colors.length],
                              // Todo: change column to stack
                              child: Stack(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset("assets/icons/pin.svg"),
                                          SizedBox(width: size.width * 0.01),
                                          // start custom menu pop up
                                          CustomPopupMenu(
                                            arrowColor: textLight,
                                            controller: _pinController[test[index].id],
                                            pressType: PressType.singleClick,
                                            menuBuilder: () => Container(
                                              width: size.width * 0.4,
                                              height: size.height * 0.12,
                                              decoration: const BoxDecoration(
                                                color: textLight,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Column(
                                                  children: pinMenuItems
                                                      .map(
                                                        (item) => GestureDetector(
                                                          behavior: HitTestBehavior.translucent,
                                                          onTap: () {
                                                            // Todo: hide menu after click
                                                            _pinController[test[index].id]!.hideMenu();
                                                            print(test[index].id);
                                                            if(item.id == item1) {
                                                            return print("ยกเลิกปักหมุด");
                                                            } else {
                                                              print("ลบ");
                                                            }
                                                          },
                                                          child: Expanded(
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                  border: Border(bottom: BorderSide(color: item.id == item1 ? greyLight : Colors.transparent, width: 1))
                                                                ),
                                                                height: size.height * 0.06,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(item.text, style: TextStyle(color: item.id == item1 ? primaryDarker : textMadatory, fontSize: 14),),
                                                                  ],
                                                                ),
                                                              ),
                                                          ),
                                                          ),
                                                      )
                                                    .toList(),
                                                  ),
                                            ),
                                            child: const Icon(Icons.more_horiz, color: primaryDarker,)
                                          ),
                                          // end custom menu pop up
                                        ],
                                      )
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  // Todo: add like text
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      test[index].text,
                                      style: TextStyle(fontSize: 16),
                                      maxLines: 2, 
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                  ),
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
                        itemCount: test.length,
                        itemBuilder: (context, index) {
                           for (var val in test) {
                            _notPinController[val.id] = new CustomPopupMenuController();
                          }
                          var item1 = menuItems[0].id;
                          return Container(
                            padding: EdgeInsets.all(size.height * 0.015),
                            color: colors[index % colors.length],
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset("assets/icons/pin.svg"),
                                          SizedBox(width: size.width * 0.01),
                                          // start custom menu pop up
                                          CustomPopupMenu(
                                            arrowColor: textLight,
                                            controller: _notPinController[test[index].id],
                                            pressType: PressType.singleClick,
                                            menuBuilder: () => Container(
                                              width: size.width * 0.4,
                                              height: size.height * 0.12,
                                              decoration: const BoxDecoration(
                                                color: textLight,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Column(
                                                  children: menuItems
                                                      .map(
                                                        (item) => GestureDetector(
                                                          behavior: HitTestBehavior.translucent,
                                                          onTap: () {
                                                            // Todo: hide menu after click
                                                            // setState(() {
                                                            //   _notPinController[test[index].id]!.hideMenu();
                                                            // });
                                                            _notPinController[test[index].id]!.hideMenu();
                                                            print(test[index].id);
                                                            if(item.id == item1) {
                                                            return print("ปักหมุด");
                                                            } else {
                                                              print("ลบ");
                                                            }
                                                          },
                                                          child: Expanded(
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                  border: Border(bottom: BorderSide(color: item.id == item1 ? greyLight : Colors.transparent, width: 1))
                                                                ),
                                                                height: size.height * 0.06,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(item.text, style: TextStyle(color: item.id == item1 ? primaryDarker : textMadatory, fontSize: 14),),
                                                                  ],
                                                                ),
                                                              ),
                                                          ),
                                                          ),
                                                      )
                                                    .toList(),
                                                  ),
                                            ),
                                            child: const Icon(Icons.more_horiz, color: primaryDarker,)
                                          ),
                                          // end custom menu pop up
                                        ],
                                      )
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  // Todo: add like text
                                  Text(
                                    test[index].text,
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