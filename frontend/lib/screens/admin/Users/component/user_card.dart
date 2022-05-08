import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MenuItem { item1, item2, item3 }

class UserCard extends StatelessWidget {
  final String text;
  final VoidCallback onTab;
  final IconButton icon, reportIcon;

  const UserCard({
    Key? key,
    required this.size,
    required this.text,
    required this.onTab,
    required this.icon,
    required this.reportIcon,
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
          reportIcon,
          Spacer(),
          Icon(
            Icons.more_vert_rounded,
            size: 20,
            color: primaryColor,
          )
        ],
      ),
    ));
  }
}
