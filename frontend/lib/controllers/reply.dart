import 'package:get/get.dart';

class ReplyController extends GetxController {
  RxBool isReply = false.obs;
  RxString message = ''.obs;
  RxString chatid = ''.obs;
  RxString type = 'text'.obs;

  void onInit() {
    super.onInit;
  }

  updateReply(getmessage, _isReply, getChatid, getType) {
    isReply.value = _isReply;
    message.value = getmessage;
    chatid.value = getChatid;
    type.value = getType;
    update();
  }

  fetchReply() {
    isReply.obs;
    message.obs;
    chatid.obs;
    type.obs;
  }
}
