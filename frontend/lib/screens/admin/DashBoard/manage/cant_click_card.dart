import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MenuItem { item1, item2, item3 }

class CantClickCard extends StatelessWidget {
  final String text;
  final VoidCallback onTab;

  const CantClickCard({
    Key? key,
    required this.size,
    required this.text,
    required this.onTab,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTab,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.05,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ));
  }
}
