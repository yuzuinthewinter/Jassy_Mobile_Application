import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  var currentUser = FirebaseAuth.instance.currentUser;

  RxString groupid = ''.obs;
  RxString postid = ''.obs;
  RxString statusUser = ''.obs;
  RxList userGroup = [].obs;

  @override
  void onInit() {
    fetchCurrentUserPost();
    super.onInit;
  }

  updatePostid(getpostid) async {
    await fetchCurrentUserPost();
    postid.value = getpostid;
    var snapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .where('postid', isEqualTo: postid.value)
        .get();
    if (snapshot.docs.isNotEmpty) {
      groupid.value = snapshot.docs[0]['groupid'];
      update();
    }
  }

  fetchCurrentUserPost() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('uid', isEqualTo: currentUser!.uid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      statusUser.value = snapshot.docs[0]['userStatus'];
      userGroup.value = snapshot.docs[0]['groups'];
      groupid.value = groupid.value;
      update();
    }
  }
}
