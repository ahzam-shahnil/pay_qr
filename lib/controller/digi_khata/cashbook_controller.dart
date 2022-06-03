import 'package:get/get.dart';
import 'package:pay_qr/model/digi_khata/cash_model.dart';

import '../../config/app_constants.dart';

class CashbookController extends GetxController {
  static CashbookController instance = Get.find();
  var totalHisaab = 0.0.obs;
  // var totalPaisayDene = 0.0.obs;

  calculateTotalHisaab(List<CashModel> cashRecords) {
    double diye = 0;
    double liye = 0;
    for (var item in cashRecords) {
      if (item.isMainDiye) {
        diye += double.parse(item.paisay);
      } else {
        liye += double.parse(item.paisay);
      }
    }
    logger.d(diye);
    logger.d(liye);
    totalHisaab.value = liye - diye;
    logger.d(totalHisaab);
  }

  resetData() {
    totalHisaab.value = 0.0;
  }
}
