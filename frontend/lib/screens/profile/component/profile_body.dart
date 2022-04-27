import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/screens/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBody();
}

class _ProfileScreenBody extends State<ProfileScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('uid', isNotEqualTo: currentUser!.uid)
              .snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var user = snapshot.data!.docs[0];
            return ProfilePictureWidget(size: size, user: user);
          }
        ),
        SizedBox(height: size.height *0.01,),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('uid', isEqualTo: currentUser!.uid)
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var user = snapshot.data!.docs;
              if (user.isEmpty) {
                return const Text('Please field your infomation!');
              }
              return Text(
                user[0]['name']['firstname'].toString() + ' ' + user[0]['name']['lastname'].toString(),
                style: const TextStyle(fontSize: 20, fontFamily: 'kanit', fontWeight: FontWeight.w600),
              );
            },
        ),
        SizedBox(height: size.height *0.03,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.13),
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
          width: size.width,
          height: size.height * 0.21,
          decoration: BoxDecoration(
            color: textLight,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              ProfileMenu(
                size: size,
                icon: SvgPicture.asset("assets/icons/profile_icon.svg"),
                text: "ตั้งค่าโพรไฟล์",
                onTab: () {},
              ),
              ProfileMenu(
                size: size,
                icon: SvgPicture.asset("assets/icons/help_center_icon.svg"),
                text: "ศูนย์ช่วยเหลือ",
                onTab: () {},
              ),
              ProfileMenu(
                size: size,
                icon: SvgPicture.asset("assets/icons/app_setting_icon.svg"),
                text: "การตั้งค่า",
                onTab: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: size.height *0.03,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.13),
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
          width: size.width,
          height: size.height * 0.15,
          decoration: BoxDecoration(
            color: textLight,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              ProfileMenu(
                size: size,
                icon: SvgPicture.asset("assets/icons/about_jassy_icon.svg"),
                text: "เกี่ยวกับแจสซี่",
                onTab: () {},
              ),
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/log_out_icon.svg"),
                      SizedBox(width: size.width * 0.03,),
                      Text("ออกจากระบบ", style: TextStyle(color: textMadatory),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 20, color: textMadatory,)
                    ],
                  ),
                  onTap: () async {
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    await _auth.signOut();
                    Navigator.pushNamed(context, Routes.LandingPage);
                  },
                )
              )
            ]
          ),
        )
      ],
    );
  }
}
