import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';

class DeleteWarningPopUp extends StatelessWidget {

  final VoidCallback onPress;

  const DeleteWarningPopUp({
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
            SvgPicture.asset("assets/icons/warning.svg",),
            SizedBox(height: size.height * 0.04,),
            Text("WarningDelete".tr, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            SizedBox(height: size.height * 0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButtonComponent(
                  text: "Delete".tr, 
                  minimumSize: Size(size.width * 0.3, size.height * 0.05), 
                  press: onPress
                ),
                SizedBox(width: size.width * 0.04,),
                RoundButton(
                  text: "Cancel".tr, 
                  minimumSize: Size(size.width * 0.3, size.height * 0.05), 
                  press: () {Navigator.of(context).pop();}
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}