import 'package:get/get.dart';

class ReplyController extends GetxController {
  RxBool isReply = false.obs;
  RxString message = ''.obs;
  RxString chatid = ''.obs;

  void onInit() {
    super.onInit;
  }

  updateReply(getmessage, _isReply, getChatid) {
    isReply.value = _isReply;
    message.value = getmessage;
    chatid.value = getChatid;
    update();
  }
}
