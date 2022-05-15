import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/mark_message_as_like_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/popup_page/delete_popup.dart';
import 'package:flutter_application_1/component/popup_page/popup_with_button/warning_popup_with_button.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/screens/main-app/profile/mark_as_like/message_as_like_detail.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarkMessageAsLike extends StatefulWidget {
  const MarkMessageAsLike({ Key? key }) : super(key: key);

  @override
  State<MarkMessageAsLike> createState() => _MarkMessageAsLikeState();
}

class _MarkMessageAsLikeState extends State<MarkMessageAsLike> {
  List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MarkMessageAsLikeAppBar(
        actionWidget: IconButton(
          onPressed: () {
            print(isSelected);
            setState(() {
              isSelected = !isSelected;
            });
          },
          icon: isSelected ? Text("ลบ", style: TextStyle(fontSize: 18, color: textMadatory),) : const Icon(Icons.check_circle_outline_rounded),
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
                    padding: EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: size.height * 0.02),
                    child: const Text("Group Name", style: TextStyle(fontSize: 20, color: greyDark),),
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
                          var isSelect = isSelected;
                          return favMassageItem(context, index);
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
  
   Widget favMassageItem (context, int index) {
   List colors = [primaryLightest, tertiaryLightest, secoundaryLightest];
   Size size = MediaQuery.of(context).size;
   return InkWell(
    onTap: () {
      // go to detail page
      var color = index % colors.length;
      isSelected ? Container() :
       Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageAsLikeDetail(color: color, data: test[index],)
        )
      );
    },
    child: Container(
      padding: EdgeInsets.all(size.height * 0.015),
      color: colors[index % colors.length],
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: isSelected
              ? InkWell(
                onTap: () {
                  // Todo: setState is not update
                  print(test[index].isIndexCheck);
                  setState(() {
                    test[index].isIndexCheck == !test[index].isIndexCheck;
                  });
                  print(!test[index].isIndexCheck);
                  print(test[index].isIndexCheck);
                 },
                child: test[index].isIndexCheck ? SvgPicture.asset("assets/icons/check_circle.svg") : SvgPicture.asset("assets/icons/uncheck_circle.svg")
              )
              : InkWell(
                onTap: () {
                  print("del");
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return DeleteWarningPopUp(
                        onPress: () {}
                      );
                    }
                  );
                },
                child: SvgPicture.asset("assets/icons/del_bin.svg")
              )
            ),
          SizedBox(height: size.height * 0.01),
          Align(
            alignment: Alignment.center,
            child: Text(
              test[index].text,
              style: TextStyle(fontSize: 16),
                maxLines: 2, 
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
        ),
      ),
    );
 }
}