import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorPopUpNoButton extends StatelessWidget {

  final String text;

  const ErrorPopUpNoButton({
    Key? key, this.text = '',
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
        height: size.height * 0.35,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/error.svg",),
            SizedBox(height: size.height * 0.01,),
            Text(text, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            
          ],
        ),
      ),
    );
  }
}