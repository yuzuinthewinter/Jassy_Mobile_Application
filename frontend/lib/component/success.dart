import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sucess extends StatelessWidget {
  final String text;
  const Sucess({ 
    Key? key, 
    this.text = ''
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.2,),
          SvgPicture.asset('assets/icons/success.svg', height: size.height * 0.15,),
          SizedBox(height: size.height * 0.03,),
          Text(
            text,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}