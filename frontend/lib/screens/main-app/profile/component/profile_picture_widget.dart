import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/theme/index.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final QueryDocumentSnapshot<Object?> user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CurvedWidget(child: JassyGradientColor(gradientHeight: size.height * 0.27,)),
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: primaryLighter),
                ),
                child: CircleAvatar(
                  backgroundImage: !user['profilePic'].isEmpty
                    ? NetworkImage(user['profilePic'][0])
                    : const AssetImage("assets/images/user3.jpg")as ImageProvider,
                  radius: 60,
                ),
              ),
            ),
          ],
        ),
        
      ],
    );
  }
}