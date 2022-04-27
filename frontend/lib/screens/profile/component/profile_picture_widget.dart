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
        CurvedWidget(child: JassyGradientColor(gradientHeight: size.height * 0.31,)),
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.17),
                height: size.width * 0.3,
                width: size.height * 0.3,
                decoration:  BoxDecoration(
                  color: textLight,
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: primaryLighter),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: !user['profilePic'].isEmpty 
                    ? NetworkImage(user['profilePic'][0])
                    : const AssetImage("assets/images/header_img1.png")
                        as ImageProvider,
                  )
                ),
              ),
            ),
            //Todo move to edit profile
            // Positioned(
            //   top: size.height * 0.24,
            //   right: size.width * 0.34,
            //   child: Container(
            //     width: size.width * 0.09,
            //     height: size.height * 0.09,
            //     decoration: BoxDecoration(
            //       color: textLight,
            //       shape: BoxShape.circle,
            //       border: Border.all(width: 3, color: primaryLight)
            //     ),
            //     child: Icon(Icons.mode_edit_outline_rounded, size: 20, color: primaryLight,)
            //   )
            // ),
          ],
        ),
        
      ],
    );
  }
}