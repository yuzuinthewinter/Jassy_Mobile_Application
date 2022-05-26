import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/back_only_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/controllers/currentUser.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/post_detail.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavedPost extends StatefulWidget {
  final user;
  const SavedPost(this.user, {Key? key}) : super(key: key);

  @override
  State<SavedPost> createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackOnlyAppBar(
        text: "ProfileSavedPost".tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              "ProfileSavedPost".tr,
              style: TextStyle(fontSize: 20, color: greyDark),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Expanded(
              child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: size.height * 0.8,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('SavePosts')
                        .where('savedBy', isEqualTo: widget.user['uid'])
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
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text(''));
                      }
                      var savepost = snapshot.data!.docs[0];
                      return ListView.builder(
                          padding: const EdgeInsets.only(top: 0),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: savepost['saved'].length,
                          itemBuilder: (context, index) {
                            int reverse = savepost['saved'].length - 1 - index;
                            return InkWell(
                                onTap: () {PostDetailController postController =
                                        PostDetailController();

                                    postController.updatePostid(
                                        savepost['saved'][reverse]);
                                    Future.delayed(
                                      const Duration(seconds: 2),
                                      () => 'Data Loaded',
                                    );
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    
                                    return PostDetail(
                                      postid: savepost['saved'][reverse],
                                    );
                                  }));
                                },
                                child: savedListItem(
                                    savepost['saved'][reverse], reverse));
                          });
                    }),
              )
            ]),
          ))
        ],
      ),
    );
  }

  Widget savedListItem(postid, index) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // color: secoundary,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      height: size.height * 0.15,
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .where('postid', isEqualTo: postid)
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
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text(''));
          }
          var post = snapshot.data!.docs[0];
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('uid', isEqualTo: post['postby'])
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
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text(''));
              }
              var postOwner = snapshot.data!.docs[0];
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Community')
                    .where('groupid', isEqualTo: post['groupid'])
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
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text(''));
                  }
                  var group = snapshot.data!.docs[0];
                  return Row(
                    children: [
                      // image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: size.width * 0.25,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              // Todo: if post has image show post image im only text show writer profilepics (or use group pic)
                              image: NetworkImage(post['picture'] == ''
                                  ? postOwner['profilePic'].length == 0
                                      ? group['coverPic']
                                      : postOwner['profilePic'][0]
                                  : post['picture']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // post text
                      Expanded(
                          child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['text'],
                              style: const TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: greyDark,
                                      fontFamily: 'kanit'),
                                  children: [
                                    TextSpan(
                                      text: "ProfileSavedPostBy".tr,
                                    ),
                                    TextSpan(
                                      text: StringUtils.capitalize(
                                          group['namegroup']),
                                    )
                                  ]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )),
                      // more icon
                      InkWell(
                        onTap: () {
                          savedPostMoreBottomsheet(context, index, postid);
                        },
                        child: Icon(Icons.more_horiz,
                            color: primaryColor, size: size.width * 0.08),
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<dynamic> savedPostMoreBottomsheet(
      BuildContext context, index, postid) {
    Size size = MediaQuery.of(context).size;
    var currentUser = FirebaseAuth.instance.currentUser;

    CollectionReference savePosts =
        FirebaseFirestore.instance.collection('SavePosts');

    unsavePost(postid) async {
      await savePosts.doc(currentUser!.uid).update({
        'saved': FieldValue.arrayRemove([postid]),
      });
    }

    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => SizedBox(
              height: size.height * 0.25,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close,
                            color: primaryDarker,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Todo: see post
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            
                            return PostDetail(
                              postid: postid,
                            );
                          }));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: SizedBox(
                            height: size.height * 0.06,
                            // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/see_post.svg",
                                  width: size.width * 0.08,
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Text(
                                  "ProfileSeeSavedPost".tr,
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      InkWell(
                        onTap: () {
                          unsavePost(postid);
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: SizedBox(
                            height: size.height * 0.06,
                            // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/unsaved_list.svg",
                                  width: size.width * 0.08,
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Text(
                                  "เลิกบันทึก",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ));
  }
}
