import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/status_code.dart';

import 'exceptions.dart';

@injectable
class ApiErrorHandler {
  dynamic handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
          case StatusCode.badResponse:
            throw BadResponseException(error.response?.data['message']);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();
    }
  }

  dynamic handleDioErrorByStatusCode(int statusCode, String message) {
    switch (statusCode) {
      case StatusCode.badRequest:
        throw BadResponseException(message);
      case StatusCode.unauthorized:
      case StatusCode.forbidden:
        throw const UnauthorizedException();
      case StatusCode.notFound:
        throw NotFoundException(message);
      case StatusCode.conflict:
        throw const ConflictException();
      case StatusCode.internalServerError:
        throw const InternalServerErrorException();
      case StatusCode.badResponse:
        throw BadResponseException(message);
      default:
        throw const InternalServerErrorException();
    }
  }
}
