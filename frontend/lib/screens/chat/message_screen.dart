import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/text/report_choice.dart';
import 'package:flutter_application_1/models/demo_chat_message.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/chat/component/message_screen_body.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MenuItem { item1, item2, item3}

class ChatRoom extends StatefulWidget {
  const ChatRoom({ Key? key, required this.user,  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
  final ChatUser user;
}

class _ChatRoomState extends State<ChatRoom> {

  bool isNotificationOn = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            // Note: map chat room name on appbar here
            Text(widget.user.name, style: TextStyle(fontSize: 18, color: textDark),),
            const Text('3 mins ago', style: TextStyle(fontSize: 14, color: greyDark),),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20,),
          color: primaryDarker,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.phone), 
            color: primaryDarker,
          ),
          PopupMenuButton<MenuItem>(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onSelected: (value) => {
              if (value == MenuItem.item1) {
               print("turn off notification"),
               _toggleNotification,
               print(isNotificationOn)
              }else if (value == MenuItem.item2) {
               print("cancel pairing")
              }else if (value == MenuItem.item3) {
                reportModalBottomSheet(context),
                print('report')
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItem.item1,
                onTap: () {
                  print(isNotificationOn);
                  _toggleNotification;
                },
                child: Row(
                  children: [
                    isNotificationOn ? 
                    SvgPicture.asset("assets/icons/notification_on.svg") : SvgPicture.asset("assets/icons/notification_off.svg"),
                    isNotificationOn ?
                    const Text("เปิดการแจ้งเตือน") : const Text("ปิดการแจ้งเตือน"),
                  ],
                )
              ),
              PopupMenuItem(
                value: MenuItem.item2,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/cancel_pairing.svg"),
                    const Text("ยกเลิกการจับคู่"),
                  ],
                )
              ),
              PopupMenuItem(
                value: MenuItem.item3,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/report.svg"),
                    const Text("รายงาน"),
                  ],
                )
              ),
            ],
            icon: const Icon(Icons.more_vert, color: primaryDarker,),
          )
        ],
      ),
      body: MessageScreenBody(user: widget.user,),
    );
  }

  void _toggleNotification () {
    setState(() {
      isNotificationOn =! isNotificationOn;  
    });
  } 

  Future<dynamic> reportModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              context: context, 
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.60,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Column(
                  children: const [
                    Text("รายงาน", style: TextStyle(fontSize: 16),),
                    Align(alignment: Alignment.topLeft, child: Text("โปรดเลือกปัญหา", style: TextStyle(fontSize: 16), )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                      child: Text("หากท่านรู้สึกตกอยู่ในอันตราย โปรดขอความช่วยเหลือก่อนรายงานปัญหาให้กับแจสซี่ทราบ", style: TextStyle(fontSize: 14, color: greyDark),),
                    ),
                    ReportTypeChoice(text: 'ภาพโป๊เปลือย',),
                    ReportTypeChoice(text: 'ความรุนแรง',),
                    ReportTypeChoice(text: 'การคุกคาม',),
                    ReportTypeChoice(text: 'คำหยาบคาย',),
                    ReportTypeChoice(text: 'การก่อการร้าย',),
                    ReportTypeChoice(text: 'การใช้แรงงานเด็ก',),
                    ReportTypeChoice(text: 'การแสวงหาผลประโยชน์ทางเพศ',),
                    ReportTypeChoice(text: 'การทำร้ายทารุณสัตว์',),
                    ReportTypeChoice(text: 'หลอกลวงต้มตุ๋น',),
                    ReportTypeChoice(text: 'สนับสนุนการใช้สารเสพติด',),
                    ReportTypeChoice(text: 'สนับสนุนการใช้สารเสพติด',),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text("รายงาน", style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                      //     // Spacer(),
                      //     IconButton(onPressed: () { Navigator.pop(context); }, icon: SvgPicture.asset("assets/icons/close_icon.svg"),)
                      //   ],
                      // )
                  ],
                ),
              )
            );
    }
}