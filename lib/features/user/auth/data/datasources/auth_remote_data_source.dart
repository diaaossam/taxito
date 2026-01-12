import 'package:taxito/config/helper/token_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/config/helper/device_helper.dart';
import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../captain/auth/data/models/request/otp_params.dart';
import '../../domain/entity/register_params.dart';
import '../models/request/login_params.dart';
import '../models/response/user_model.dart';
import '../models/response/user_model_helper.dart';

abstract class AuthRemoteDataSource {
  Future<ApiSuccessResponse> verifyOtp({required OtpParams otpParams});

  Future<ApiSuccessResponse> deleteUser();

  Future<ApiSuccessResponse> logOut();

  Future<ApiSuccessResponse> getUserData();

  Future<ApiSuccessResponse> loginUser({required LoginParams params});

  Future<ApiSuccessResponse> updateUserData({required RegisterParams params});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioConsumer dioConsumer;
  final SharedPreferences sharedPreferences;
  final DeviceHelper deviceHelper;
  final TokenRepository tokenRepository;

  AuthRemoteDataSourceImpl({
    required this.dioConsumer,
    required this.sharedPreferences,
    required this.tokenRepository,
    required this.deviceHelper,
  });

  @override
  Future<ApiSuccessResponse> verifyOtp({required OtpParams otpParams}) async {
    final response = await dioConsumer.post(
      path: EndPoints.verifyUser,
      body: otpParams.toJson(),
    );
    String accessToken = response['data']['access_token'];
    UserModel userModel = UserModel.fromJson(response['data']['auth']);
    UserDataService().setUserData(userModel);
    await tokenRepository.saveToken(accessToken);
    await sharedPreferences.setBool(AppStrings.isGuest, false);
    await ApiConfig().init();
    return ApiSuccessResponse(data: userModel);
  }

  @override
  Future<ApiSuccessResponse> getUserData() async {
    final response = await dioConsumer.get(path: EndPoints.profile);
    final UserModel userModel = UserModel.fromJson(response['data']);
    return ApiSuccessResponse(data: userModel);
  }

  @override
  Future<ApiSuccessResponse> logOut() async {
    final response = await dioConsumer.post(path: EndPoints.logOut);
    UserDataService().clearUserData();
    await sharedPreferences.clear();
    await tokenRepository.deleteToken();
    await ApiConfig().init();
    return ApiSuccessResponse();
  }

  @override
  Future<ApiSuccessResponse> loginUser({required LoginParams params}) async {
    final response = await dioConsumer.post(
      path: EndPoints.loginUser,
      body: params.map(),
    );
    return ApiSuccessResponse(data: response['data']);
  }

  @override
  Future<ApiSuccessResponse> deleteUser() async {
    final response = await dioConsumer.delete(path: EndPoints.deleteUser);
    UserDataService().clearUserData();
    await sharedPreferences.clear();
    await tokenRepository.deleteToken();
    await ApiConfig().init();
    return ApiSuccessResponse(message: response['result']);
  }

  @override
  Future<ApiSuccessResponse> updateUserData({
    required RegisterParams params,
  }) async {
    final String? token = await tokenRepository.token;
    Map<String, dynamic> map = {};
    map.addAll(params.toJson());
    if (params.imagePath != null) {
      map.addAll({
        "profile_image": await MultipartFile.fromFile(params.imagePath ?? ""),
      });
    }
    final response = await dioConsumer.post(
      path: EndPoints.update,
      data: FormData.fromMap(map),
    );

    final user = await getUserData();
    UserDataService().setUserData(user.data);
    return ApiSuccessResponse(message: response['message']);
  }
}
