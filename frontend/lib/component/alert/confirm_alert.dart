import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/outlined_button.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/screens/forgot_password/change_password_success.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmAlert extends StatelessWidget {
  const ConfirmAlert({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        height: 300,
        width: 338,
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.0),
        child: Column(
          children: [
            SvgPicture.asset("assets/icons/warning.svg",),
            SizedBox(height: size.height * 0.04,),
            const Text("คุณแน่ใจใช่หรือไม่ว่าต้องการเปลี่ยนรหัสผ่าน", style: TextStyle(fontSize: 18),),
            SizedBox(height: size.height * 0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButtonComponent(text: "ยกเลิก", minimumSize: Size(75, 36), press: () {Navigator.of(context).pop();}),
                RoundButton(
                  text: "ตกลง", 
                  minimumSize: const Size(75, 36), 
                  press: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangePasswordSuccess()),
                    );
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}