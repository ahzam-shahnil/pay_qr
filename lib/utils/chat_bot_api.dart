// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/app_exceptions.dart';

class ApiService {
  static const int kTimeOutDuration = 10;
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;

      case 201:
        var responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }

  Future<dynamic> getQueryResult(String path) async {
    var url = kChatBotUrl;
    log(url);
    try {
      var uri = Uri.parse(url + path);
      var response = await http
          .get(uri)
          .timeout(const Duration(seconds: kTimeOutDuration));
      // Logger lo = Logger();
      logger.d(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection', kChatBotUrl + path.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', kChatBotUrl + path.toString());
    }
  }
}
