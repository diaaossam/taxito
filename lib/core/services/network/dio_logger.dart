import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

extension OptionsExtension on RequestOptions {}

enum _StatusType { succeed, failed }

class DioLogInterceptor extends Interceptor {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  final Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      logger.i("***|| ${options.method} ${options.uri} ||***"
          "\n param : ${options.queryParameters}"
          "\n token : ${options.headers['Authorization']}"
          "\n data : ${options.data}");
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      _StatusType statusType;
      if (response.statusCode == 200) {
        statusType = _StatusType.succeed;
      } else {
        statusType = _StatusType.failed;
      }

      // Decode JSON data
      var decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;

      logger.f(
        "***|| INFO Response Request ${response.requestOptions.uri.path} ${statusType == _StatusType.succeed ? '✊' : ''} ||***"
        "\n Status code: ${response.statusCode}"
        "\n Status message: ${response.statusMessage}"
        "\n Data: ${encoder.convert(decodedData)}",
      );
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      Logger(printer: PrettyPrinter(methodCount: 8)).e(
        "***|| ${err.requestOptions.uri.path} ||***"
        "\n response: ${err.response}"
        "\n message: ${err.message}"
        "\n type: ${err.type}",
        error: err.error,
        stackTrace: err.stackTrace,
      );
    }
    handler.next(err);
  }
}
