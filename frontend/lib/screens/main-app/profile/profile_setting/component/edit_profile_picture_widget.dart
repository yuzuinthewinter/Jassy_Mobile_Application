import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/theme/index.dart';

class EditProfilePictureWidget extends StatelessWidget {
  const EditProfilePictureWidget({
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
        CurvedWidget(child: JassyGradientColor(gradientHeight: size.height * 0.25,)),
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  // Todo: go to edit profile pic
                },
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.11),
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
            ),
            // Positioned(
            //   top: size.height * 0.25,
            //   right: size.width * 0.34,
            //   child: InkWell(
            //     onTap: () {
            //       // Todo: go to edit profile pic
            //     },
            //     child: Container(
            //       width: size.width * 0.09,
            //       height: size.height * 0.09,
            //       decoration: BoxDecoration(
            //         color: textLight,
            //         shape: BoxShape.circle,
            //         border: Border.all(width: 3, color: primaryLight)
            //       ),
            //       child: const Icon(Icons.mode_edit_outline_rounded, size: 20, color: primaryLight,)
            //     ),
            //   )
            // ),
          ],
        ),
        
      ],
    );
  }
}