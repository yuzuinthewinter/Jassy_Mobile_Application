import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuCard extends StatelessWidget {
  final String text;
  final VoidCallback onTab;
  final IconButton icon;

  const MenuCard({
    Key? key,
    required this.size,
    required this.text,
    required this.onTab,
    required this.icon,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTab,
      child: Row(
        children: [
          icon,
          SizedBox(
            width: size.width * 0.03,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: primaryColor,
          )
        ],
      ),
    ));
  }
}
