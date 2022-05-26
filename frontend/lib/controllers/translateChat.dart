import 'package:get/get.dart';

class TranslateChatController extends GetxController {
  RxBool isTranslate = false.obs;

  void onInit() {
    fetchTranslate();
    super.onInit;
  }

  updateTranslateChat() {
    isTranslate.value = !isTranslate.value;
    print('update : ${isTranslate.value}');
    update();
  }

  fetchTranslate() {
    isTranslate.obs;
    print('fetch : ${isTranslate.value}');
    update();
  }
}
