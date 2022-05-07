import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';

class WritePostBody extends StatefulWidget {
  const WritePostBody({ Key? key }) : super(key: key);

  @override
  State<WritePostBody> createState() => _WritePostBodyState();
}

class _WritePostBodyState extends State<WritePostBody> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        CurvedWidget(child: JassyGradientColor(gradientHeight: size.height * 0.23,)),
      ],
    );
  }
}