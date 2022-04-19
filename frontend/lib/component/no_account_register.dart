import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/register/register_page.dart';
import 'package:flutter_application_1/theme/index.dart';

class NoAccountRegister extends StatelessWidget {
  const NoAccountRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: const TextStyle(
              color: greyDark,
              fontFamily: 'Kanit',
            ),
            children: [
              const TextSpan(text: 'ยังไม่มีบัญชีผู้ใช้ ? '),
              TextSpan(
                  text: 'ลงทะเบียนสำหรับผู้ใช้ใหม่ ',
                  style: const TextStyle(
                    color: primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => {
                          Navigator.pushNamed(
                            context,
                            Routes.RegisterPage,
                          ),
                        }),
            ]),
      ),
    );
  }
}
