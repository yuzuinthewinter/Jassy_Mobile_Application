import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/success.dart';

class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: const [
        Sucess(
          titleText: "รหัสผ่านของคุณถูกเปลี่ยนสำเร็จ",
          subtitleText: "กรุณาปิดหน้าต่างนี้ และ เข้าสู่ระบบใหม่อีกครั้ง",
        ),
        // SizedBox(height: size.height * 0.23,),
        // RoundButton(
        //   text: "ถัดไป", 
        //   minimumSize: Size(279, 36), 
        //   press: () {
        //     Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const RegisterProfile()),
        //     );
        //   })
      ],
    );
  }
}