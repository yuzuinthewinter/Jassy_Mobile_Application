import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';

class CommunityScreenBody extends StatefulWidget {
  const CommunityScreenBody({ Key? key }) : super(key: key);

  @override
  State<CommunityScreenBody> createState() => _CommunityScreenBodyState();
}

class _CommunityScreenBodyState extends State<CommunityScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurvedWidget(child: JassyGradientColor()),
      ],
    );
  }
}