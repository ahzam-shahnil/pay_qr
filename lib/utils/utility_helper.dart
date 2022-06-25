import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/model/digi_khata/cash_model.dart';

import '../model/customer.dart';

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
    return total = total + (-diye) + (liye);
  }

  calculateTotalHisaab(List<CashModel> cashRecords) {
    double totalHisaab;
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
    totalHisaab = liye - diye;
    logger.d(totalHisaab);
    return totalHisaab;
  }

  static String calculateHisaab(
      {required double totalLene, required double totalDene}) {
    double total = (totalLene - totalDene);
    return total < 0 ? 'Hisaab Clear h' : total.toStringAsFixed(0);
  }

  static String calculateDigiTotal({required List<CustomerModel> customers}) {
    double total = 0;
    // customers.map((e) => total += Utility.calculateAmount(e.cashRecords));
    total = customers.fold(
        total,
        (double previousValue, element) =>
            previousValue + calculateAmount(element.cashRecords));
    logger.d(total);
    return total.toStringAsFixed(0);
  }

  // static double calculateDigiTotal({required List<CashModel> records}) {
  //   double total = 0;
  //   double diye = 0;
  //   double liye = 0;
  //   for (var item in records) {
  //     if (item.isMainDiye) {
  //       diye += double.parse(item.paisay);
  //     } else {
  //       liye += double.parse(item.paisay);
  //     }
  //   }
  //   total = total + diye + (-liye);

  //   if (total < 0) {
  //     amountController.totalPaisayDene.value += total;
  //   } else {
  //     amountController.totalPaisayLene.value += total;
  //   }
  //   return total;
  // }
}
