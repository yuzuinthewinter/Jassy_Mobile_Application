import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/text/text_field_label.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/profile/component/edit_profile_picture_widget.dart';
import 'package:flutter_application_1/screens/profile/profile_menu/component/profile_setting_tabbar.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

// Todo: disable gender
class ProfileSettingBody extends StatefulWidget {
  const ProfileSettingBody({ Key? key }) : super(key: key);

  @override
  State<ProfileSettingBody> createState() => _ProfileSettingBodyState();
}

class _ProfileSettingBodyState extends State<ProfileSettingBody> with TickerProviderStateMixin{

  late TabController tabController;
  int currentTabIndex = 0;
  InfoType userInfo = InfoType();
  int _defaultChoiceIndex = 0;

  // state of data's user
  final List<String> _choicesLists = ["Male".tr, "Female".tr, "LGBTQ+".tr];

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
      print(currentTabIndex);
    });
  }

  @override
  void initState() {
    userInfo.genre = _choicesLists[0];

    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      onTabChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.addListener(() {
      onTabChange();
    });

    tabController.dispose();

    super.dispose();
  }

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            return EditProfilePictureWidget(size: size, user: user);
          }
        ),        
        ProfileSettingTabBar(tabController: tabController),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: TabBarView(
              controller: tabController,
              children: [
                // Profile Tab information
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldLabel(textLabel: "ชื่อ-นามสกุล"),
                                TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: user[0]['name']['firstname'].toString() + ' ' + user[0]['name']['lastname'].toString(),
                                      fillColor: grey,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide:
                                              const BorderSide(color: textLight, width: 0.0)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(color: textLight),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(color: textLight),
                                      ),
                                  ),
                                ),
                                const TextFieldLabel(textLabel: "วันเดือนปีเกิด"),
                                TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: user[0]['birthDate'].toString(),
                                      fillColor: grey,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide:
                                              const BorderSide(color: textLight, width: 0.0)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(color: textLight),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(color: textLight),
                                      ),
                                  ),
                                ),
                                const TextFieldLabel(textLabel: "เพศ"),
                                Center(
                                  child: Wrap(
                                      spacing: size.width * 0.03,
                                      alignment: WrapAlignment.spaceBetween,
                                      runAlignment: WrapAlignment.spaceBetween,
                                      children:
                                          List.generate(_choicesLists.length, (index) {
                                        return ChoiceChip(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.04),
                                          label: Text(_choicesLists[index]),
                                          selected: _defaultChoiceIndex == index,
                                          onSelected: (value) {
                                            setState(() {
                                              _defaultChoiceIndex =
                                                  value ? index : _defaultChoiceIndex;
                                              _defaultChoiceIndex;
                                              userInfo.genre =
                                                  _choicesLists[_defaultChoiceIndex];
                                            });
                                          },
                                          backgroundColor: textLight,
                                          selectedColor: primaryLightest,
                                          labelStyle: TextStyle(
                                            color: _defaultChoiceIndex == index
                                                ? primaryColor
                                                : greyDark,
                                          ),
                                        );
                                      })),
                                ),
                                const TextFieldLabel(textLabel: "คำบรรยายของคุณ"),
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  // readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: user[0]['desc'].toString(),
                                      fillColor: textLight,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide:
                                              const BorderSide(color: textLight, width: 0.0)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(color: textLight),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(color: textLight),
                                      ),
                                  ),
                                ),
                              ],
                            );
                          },
                      ),
                    ],
                  ),
                ),
                // Language Tab information
                Column(
                  children: [],
                ),
              ]
            ),
          ),
        ),
        Center(
          child: RoundButton(
          text: "บันทึกการเปลี่ยนแปลง", 
          minimumSize: Size(size.width * 0.8, size.height * 0.05), 
          press: () {}
          ),
        ),
        SizedBox(height: size.height * 0.02,)
      ],
    );
  }
}