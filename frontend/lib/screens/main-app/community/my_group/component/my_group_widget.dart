import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';

Widget myGroupWidget (group, context) {
  var size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      width: double.infinity,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: textLight,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 5),
          )
        ]
      ),
      child: Row(
        children: [
          // Group Picture
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: size.width * 0.21,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(group['coverPic']),
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          // Group Name + member count
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group['namegroup'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  SizedBox(height: size.height * 0.01,),
                  RichText(
                      text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: greyDark, fontFamily: 'kanit'),
                      children: [
                        const WidgetSpan(child: Icon(Icons.person_rounded, color: grey,)),
                        WidgetSpan(child: SizedBox(width: size.width * 0.01,),),
                        TextSpan(text: group['membersID'].length.toString(), style: const TextStyle(fontSize: 16),)
                      ]
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}