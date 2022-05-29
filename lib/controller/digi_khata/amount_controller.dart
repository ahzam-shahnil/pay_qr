import 'package:get/get.dart';

import '../../config/app_constants.dart';

class AmountController extends GetxController {
  static AmountController instance = Get.find();
  var totalPaisayLene = 0.0.obs;
  var totalPaisayDene = 0.0.obs;

  resetData() {
    totalPaisayLene.value = 0.0;
    totalPaisayDene.value = 0.0;
  }

  @override
  void onDetached() {
    logger.d("deatched");
  }

  @override
  void onInactive() {
    logger.d("on ina active");
  }

  @override
  void onPaused() {
    logger.d("on paused");
  }

  @override
  void onResumed() {
    logger.d("on resume");
  }
}
