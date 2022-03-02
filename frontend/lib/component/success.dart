import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sucess extends StatelessWidget {
  final String titleText, subtitleText;
  
  const Sucess({ 
    Key? key, 
    this.titleText = '', 
    this.subtitleText = '', 
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.2,),
          SvgPicture.asset('assets/icons/success.svg', height: size.height * 0.15,),
          SizedBox(height: size.height * 0.05,),
          Text(
            titleText,
            style: TextStyle(fontSize: 18,),
          ),
          SizedBox(height: size.height * 0.01,),
          Text(
            subtitleText,
            style: TextStyle(fontSize: 14, color: greyDark,),
          )
        ],
      ),
    );
  }
}