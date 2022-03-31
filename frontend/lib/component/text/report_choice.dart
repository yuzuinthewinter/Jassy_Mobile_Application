import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/index.dart';

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            context: context, 
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.60,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("รายงาน", style: TextStyle(fontSize: 16),)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Text("รายละเอียดการรายงาน", style: TextStyle(fontSize: 16),),
                  ),
                  
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