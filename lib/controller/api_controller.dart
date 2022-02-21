// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/controller/base_controller.dart';
import 'package:pay_qr/services/chat_bot_api.dart';

class ApiController with BaseController {
  var response = ''.obs;

  dynamic getData(String path) async {
    // showLoading('...');
    var response =
        await ApiService().getQueryResult(path).catchError(handleError);
    if (response != null) return response;

    // hideLoading();
    // print(response);
  }
}
