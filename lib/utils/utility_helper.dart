import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay_qr/model/digi_khata/cash_model.dart';

import '../config/controllers.dart';

class Utility {
  static getFormatedDate(DateTime date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date.toString());
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return outputFormat.format(inputDate);
  }

  static DateTime combine(DateTime date, TimeOfDay? time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  // static combineDate({required DateTime date, required TimeOfDay time}) {
  //   var inputFormat = DateFormat('yyyy-MM-dd');
  //   var inputDate = inputFormat.parse(date.toString());
  //   var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
  //   return outputFormat.format(inputDate);
  // }

  static double calculateAmount(List<CashModel> records) {
    double total = 0;
    double diye = 0;
    double liye = 0;
    for (var item in records) {
      if (item.isMainDiye) {
        diye += double.parse(item.paisay);
      } else {
        liye += double.parse(item.paisay);
      }
    }
    return total = total + diye + (-liye);
  }

  static String calculateHisaab(
      {required double totalLene, required double totalDene}) {
    double total = (totalLene - totalDene);
    return total < 0 ? 'Hisaab Clear h' : total.toStringAsFixed(0);
  }

  static double calculateDigiTotal({required List<CashModel> records}) {
    double total = 0;
    double diye = 0;
    double liye = 0;
    for (var item in records) {
      if (item.isMainDiye) {
        diye += double.parse(item.paisay);
      } else {
        liye += double.parse(item.paisay);
      }
    }
    total = total + diye + (-liye);

    if (total < 0) {
      amountController.totalPaisayDene.value += total;
    } else {
      amountController.totalPaisayLene.value += total;
    }
    return total;
  }
}
