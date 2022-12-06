import 'package:get/get.dart';

class Controller extends GetxController {
  RxBool isObscure = true.obs;
  RxBool agreeCondition = false.obs;
  isAgreeCondition() {
    agreeCondition.value = !agreeCondition.value;
  }

  isObscureActive() {
    isObscure.value = !isObscure.value;
  }
}
