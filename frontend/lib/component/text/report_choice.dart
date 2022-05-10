import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/get.dart';

class ReportTypeChoice extends StatelessWidget {
  final String text;
  
  const ReportTypeChoice({
    Key? key, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      child: InkWell(
        onTap: () {
          // Navigator.pop(context);
          showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            context: context, 
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.60,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("MenuReport".tr, style: TextStyle(fontSize: 16),)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Text("ReportDetail".tr, style: TextStyle(fontSize: 16),),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "ReportFill".tr,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 10.0),
                    child: Text("ReportAttach".tr, style: TextStyle(fontSize: 16),),
                  ),
                  OutlinedButton.icon(
                    onPressed: selectFile, 
                    icon: const Icon(Icons.file_upload, color: primaryColor,),
                    label: Text("ReportAddFile".tr, style: TextStyle(color: primaryColor),),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(159, 36),
                      side: const BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    )
                  ),
                  const Spacer(),
                  Center(
                    child: RoundButton(
                      text: "MenuReport".tr, 
                      minimumSize: const Size(339, 36), 
                      press: () {},
                    ),
                  )
                ],
              ),
            )
          );
        },
        child: Row(
          children: [
            Text(text, style: const TextStyle(fontSize: 14,),),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios,color: primaryColor, size: 15,)
          ],                          ),
        ),
    );
  }
}

Future selectFile() async{
  final result = await FilePicker.platform.pickFiles();
}