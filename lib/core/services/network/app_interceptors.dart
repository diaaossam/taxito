import 'package:taxito/config/helper/token_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taxito/config/helper/context_helper.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:taxito/config/environment/environment_helper.dart' as env;

class AppInterceptors extends Interceptor {
  final TokenRepository tokenRepository;

  AppInterceptors({required this.tokenRepository});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      final BuildContext? context =
          NavigationService.navigatorKey.currentContext;
      if (context != null) {
        AppConstant().showAuthDialog(context: context);
      }
      return;
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    tokenRepository.token.then((token) {
      if (token != null) options.headers['Authorization'] = 'Bearer $token';
      options.headers[AppStrings.acceptLanguage] = ApiConfig.language?.name;
      options.headers[AppStrings.contentType] = AppStrings.applicationJson;
      options.headers[AppStrings.accept] = AppStrings.applicationJson;
      options.headers[AppStrings.xApiKey] = env.Environment.xApiKey;
      handler.next(options);
    }).catchError((error) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          type: DioExceptionType.unknown,
        ),
      );
    });
  }
}
