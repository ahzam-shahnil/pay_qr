import 'package:intl/intl.dart';
import 'package:pay_qr/model/digi_khata/cash_in_model.dart';

class Utility {
  static getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  static double calculateAmount(List<CashModel> records) {
    double total = 0;
    double diye = 0;
    double liye = 0;
    for (var item in records) {
      if (item.isMainDiye) {
        diye += item.paisay;
      } else {
        liye += item.paisay;
      }
    }
    return total = total + diye + (-liye);
  }
}
