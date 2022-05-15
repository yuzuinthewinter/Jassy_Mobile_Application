import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appbar/back_only_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/post_detail.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SavedPost extends StatefulWidget {
  const SavedPost({ Key? key }) : super(key: key);

  @override
  State<SavedPost> createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BackOnlyAppBar(text: "รายการที่บันทึกไว้",),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurvedWidget(child: JassyGradientColor()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: const Text("รายการที่บันทึกไว้", style: TextStyle(fontSize: 20, color: greyDark),),
          ),
          SizedBox(height: size.height * 0.02,),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: newsLists.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Todo: see post
                      print("see post");
                      Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                          return PostDetail(post: newsLists[index],);
                      }));
                    },
                    child: savedListItem(newsLists[index], index)
                  );
                }
              ),
            )
          )
        ],
      ),
    );
  }

  Widget savedListItem (News data, index) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: secoundary,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      height: size.height * 0.15,
      width: double.infinity,
      child: Row(
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: size.width * 0.25,
              height: size.height * 0.1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  // Todo: if post has image show post image im only text show writer profilepics (or use group pic)
                  image: AssetImage("assets/images/user4.jpg"), fit: BoxFit.cover),
              ),
            ),
          ),
          // post text
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.news, style: const TextStyle(fontSize: 18), overflow: TextOverflow.ellipsis, maxLines: 2,),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: greyDark,
                        fontFamily: 'kanit'),
                      children: [
                        TextSpan(
                          text: "บันทึกเมื่อ ",
                        ),
                        TextSpan(
                          text: "1/2/2012",
                        )
                      ]
                    )
                  )
                ],
              ),
            )
          ),
          // more icon
          InkWell(
            onTap: () {
              savedPostMoreBottomsheet(context, index);
            },
            child: Icon(
              Icons.more_horiz, 
              color: primaryColor, 
              size: size.width * 0.08
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> savedPostMoreBottomsheet(BuildContext context, index) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => Container(
          height: size.height * 0.25,
          // padding:
          //     const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(Icons.close, color: primaryDarker,)
                    ),
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
                          return PostDetail(post: newsLists[index],);
                        }));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: SizedBox(
                          height: size.height * 0.06,
                          // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/icons/see_post.svg", width: size.width * 0.08,),
                              SizedBox(width: size.width * 0.03,),
                              Text("ดูโพสต์ต้นฉบับ", style: TextStyle(fontSize: 16),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015,),
                    InkWell(
                      onTap: () {
                        // Todo: unsaved post
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: SizedBox(
                          height: size.height * 0.06,
                          // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/icons/unsaved_list.svg", width: size.width * 0.08,),
                              SizedBox(width: size.width * 0.03,),
                              Text("เลิกบันทึก", style: TextStyle(fontSize: 16),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
        ),
      )
    );
  }
}