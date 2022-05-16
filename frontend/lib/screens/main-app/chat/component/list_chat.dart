// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
// import 'package:flutter_application_1/theme/index.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// // NOTE: chat card in all chat page show name lastest message and unread notification
// class ListChat extends StatefulWidget {
//   const ListChat({Key? key}) : super(key: key);

//   @override
//   State<ListChat> createState() => _ListChatBody();
// }

// class _ListChatBody extends State<ListChat> {
//   var currentUser = FirebaseAuth.instance.currentUser;

//   TextEditingController searchController = TextEditingController();

//   getDifferance(timestamp) {
//     DateTime now = DateTime.now();
//     DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
//     Duration diff = now.difference(lastActive);
//     var timeMin = diff.inMinutes;
//     var timeHour = diff.inHours;
//     var timeDay = diff.inDays;
//     if (timeMin < 3) {
//       return 'Active a few minutes ago';
//     } else if (timeMin < 60) {
//       return 'Active ${timeMin.toString()} minutes ago';
//     } else if (timeHour < 24) {
//       return 'Active ${timeHour.toString()}h ago';
//     } else if (timeDay < 3) {
//       return 'Active ${timeDay.toString()}d ago';
//     } else {
//       return '';
//     }
//   }

//   @override
//   void initState() {
//     searchController = TextEditingController();
//     // searchController.addListener(() {});
//     super.initState();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
//           child: TextFormField(
//             controller: searchController,
//             onChanged: (desc) {
//               desc = searchController.text;
//               setState(() {});
//             },
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//               prefixIcon: SvgPicture.asset(
//                 'assets/icons/search_input.svg',
//                 height: 16,
//               ),
//               hintText: 'SearchChat'.tr,
//               filled: true,
//               fillColor: textLight,
//               // contentPadding:
//               //     const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(40),
//                   borderSide: const BorderSide(color: textLight, width: 0.0)),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(40.0),
//                 borderSide: const BorderSide(color: textLight),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(40.0),
//                 borderSide: const BorderSide(color: textLight),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: StreamBuilder<QuerySnapshot>(
//             //call all chatroom
//             stream: FirebaseFirestore.instance
//                 .collection('Users')
//                 .where('uid', isEqualTo: currentUser!.uid)
//                 .snapshots(includeMetadataChanges: true),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return const Text('Something went wrong');
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (snapshot.data!.docs.isEmpty) {
//                 return const SizedBox.shrink();
//               }
//               if (snapshot.data!.docs[0]['chats'].length == 0) {
//                 return const Center(child: Text('Let\'s start conversation'));
//               }
//               var data = snapshot.data!.docs[0];
//               return ListView.builder(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 20.0, horizontal: 20.0),
//                 itemCount: data['chats'].length,
//                 itemBuilder: (context, int index) {
//                   return ChatCard(
//                     chatid: data['chats'][index],
//                     currentUser: data,
//                     query: searchController.text.toLowerCase(),
//                   );
//                 },
//               );
//             },
//           ),
//         )
//       ],
//     );
//   }
// }
