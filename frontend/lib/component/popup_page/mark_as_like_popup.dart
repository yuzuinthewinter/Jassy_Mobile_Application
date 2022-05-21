import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';

class MarkAsLikePopUp extends StatelessWidget {

  final VoidCallback onPress;

  const MarkAsLikePopUp({
    Key? key, required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        height: size.height * 0.43,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/mark_as_like.svg", width: size.width * 0.3,),
            SizedBox(height: size.height * 0.025,),
            const Text("คุณต้องการเพิ่มข้อความนี้ลงในรายการที่ชื่นชอบหรือไม่", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            SizedBox(height: size.height * 0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButtonComponent(
                  text: "ยกเลิก", 
                  minimumSize: Size(size.width * 0.3, size.height * 0.05), 
                  press: () {Navigator.of(context).pop();}
                ),
                SizedBox(width: size.width * 0.04,),
                RoundButton(
                  text: "Confirm".tr, 
                  minimumSize: Size(size.width * 0.3, size.height * 0.05), 
                  press: onPress
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}