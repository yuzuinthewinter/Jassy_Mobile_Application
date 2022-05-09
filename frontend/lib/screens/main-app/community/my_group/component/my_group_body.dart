import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/screens/main-app/community/group_activity/group_activity_screen.dart';
import 'package:flutter_application_1/screens/main-app/community/my_group/component/my_group_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyGroupBody extends StatefulWidget {
  const MyGroupBody({ Key? key }) : super(key: key);

  @override
  State<MyGroupBody> createState() => _MyGroupBodyState();
}

class _MyGroupBodyState extends State<MyGroupBody> {
  TextEditingController searchController = TextEditingController();
  bool isSearchEmpty = true;
  late List<GroupActivity> grouplists;
  String query = '';

  @override
  void initState() {
    super.initState();
    grouplists = groupLists;

    searchController = TextEditingController();
    searchController.addListener(() {
      final isSearchEmpty = searchController.text.isNotEmpty;
      setState(() {
        this.isSearchEmpty = !isSearchEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const CurvedWidget(child: JassyGradientColor()),
          Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                'assets/icons/search_input.svg',
                height: 16,
              ),
              hintText: 'ค้นหา',
              filled: true,
              fillColor: textLight,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
            onChanged: searhGroup,
          ),
        ),
        // Todo: isEmpty show NoNewsWidget
        // NoNewsWidget(
        //   headText: "คุณยังไม่ได้เข้าร่วมกลุ่ม ",
        //   descText: "เริ่มเข้ากลุ่มเพื่อรับข่าวสารและแลกเปลี่ยนกันเถอะ !",
        //   size: size
        // )
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.03, horizontal: size.width * 0.05),
          child: Text("กลุ่มของฉัน", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
            scrollDirection: Axis.vertical,
            itemCount: grouplists.length,
            separatorBuilder: (BuildContext context, int index) { return SizedBox(height: size.height * 0.03,); },
            itemBuilder: (context, index) {
              final group = grouplists[index];
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                    CupertinoPageRoute(builder: (context) {
                    return GroupActivityScreen(groupActivity: group,);
                  }));
                },
                child: myGroupWidget(group, context)
              );
            }
          )
        )
      ],
    );
  }

  void searhGroup(String query) {
    final suggestion = grouplists.where((group) {
      final groupName = group.groupName.name.toLowerCase();
      final searchInput = query.toLowerCase();

      return groupName.contains(searchInput);
    }).toList();

    setState(() => grouplists = suggestion);
  }
}