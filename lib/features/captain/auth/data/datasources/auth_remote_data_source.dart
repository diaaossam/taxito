import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxito/config/helper/token_repository.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:taxito/features/common/models/user_type_helper.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/helper/device_helper.dart';
import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../../../core/utils/api_config.dart';
import 'package:taxito/features/common/models/register_params.dart';
import '../models/request/otp_params.dart';
import 'package:taxito/features/common/models/user_model.dart';
import '../../../../common/models/user_model_helper.dart';

abstract class AuthRemoteDataSource {
  Future<ApiSuccessResponse> registerUser({
    required RegisterParams registerParams,
  });

  Future<ApiSuccessResponse> verifyOtp({required OtpParams otpParams});

  Future<ApiSuccessResponse> deleteUser({required int reason});

  Future<ApiSuccessResponse> logOut();

  Future<ApiSuccessResponse> getUserData();

  Future<ApiSuccessResponse> loginUser({
    required String phone,
    required UserType userType,
  });

  Future<ApiSuccessResponse> resendOtp({
    required String phone,
    required UserType userType,
  });

  Future<ApiSuccessResponse> updateFcm();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioConsumer dioConsumer;
  final SharedPreferences sharedPreferences;
  final TokenRepository tokenRepository;
  final DeviceHelper deviceHelper;

  AuthRemoteDataSourceImpl({
    required this.dioConsumer,
    required this.tokenRepository,
    required this.deviceHelper,
    required this.sharedPreferences,
  });

  @override
  Future<ApiSuccessResponse> registerUser({
    required RegisterParams registerParams,
  }) async {
    Map<String, dynamic> map = {};
    map.addAll(registerParams.toJson());
    FormData formData = FormData();
    map.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    if (registerParams.profileImage != null &&
        !registerParams.profileImage!.contains("http")) {
      formData.files.add(
        MapEntry(
          'logo',
          await MultipartFile.fromFile(registerParams.profileImage.toString()),
        ),
      );
      formData.files.add(
        MapEntry(
          'profile_image',
          await MultipartFile.fromFile(registerParams.profileImage.toString()),
        ),
      );
    }
    if (registerParams.carImages != null &&
        registerParams.carImages!.isNotEmpty) {
      for (var element in registerParams.carImages!) {
        if (!element.contains("http")) {
          formData.files.add(
            MapEntry('cars[]', await MultipartFile.fromFile(element)),
          );
        }
      }
    }
    if (registerParams.frontIdImage != null &&
        !registerParams.frontIdImage!.contains("http")) {
      formData.files.add(
        MapEntry(
          'id_front_image',
          await MultipartFile.fromFile(registerParams.frontIdImage.toString()),
        ),
      );
    }
    if (registerParams.backIdImage != null &&
        !registerParams.backIdImage!.contains("http")) {
      formData.files.add(
        MapEntry(
          'id_back_image',
          await MultipartFile.fromFile(registerParams.backIdImage.toString()),
        ),
      );
    }
    if (registerParams.frontDriverLicense != null &&
        !registerParams.frontDriverLicense!.contains("http")) {
      formData.files.add(
        MapEntry(
          'driver_license_front_image',
          await MultipartFile.fromFile(
            registerParams.frontDriverLicense.toString(),
          ),
        ),
      );
    }
    if (registerParams.backDriverLicense != null &&
        !registerParams.backDriverLicense!.contains("http")) {
      formData.files.add(
        MapEntry(
          'driver_license_back_image',
          await MultipartFile.fromFile(
            registerParams.backDriverLicense.toString(),
          ),
        ),
      );
    }
    if (registerParams.frontInsurancePhoto != null &&
        !registerParams.frontInsurancePhoto!.contains("http")) {
      formData.files.add(
        MapEntry(
          'car_insurance_front_image',
          await MultipartFile.fromFile(
            registerParams.frontInsurancePhoto.toString(),
          ),
        ),
      );
    }
    if (registerParams.backInsurancePhoto != null &&
        !registerParams.backInsurancePhoto!.contains("http")) {
      formData.files.add(
        MapEntry(
          'car_insurance_back_image',
          await MultipartFile.fromFile(
            registerParams.backInsurancePhoto.toString(),
          ),
        ),
      );
    }
    final response = await dioConsumer.post(
      path: EndPoints.register(registerParams.userTypeEnum!),
      data: formData,
    );
    UserModel userModel = UserModel.fromJson(response['data']);
    UserDataService().setUserData(userModel);
    return ApiSuccessResponse();
  }

  @override
  Future<ApiSuccessResponse> verifyOtp({required OtpParams otpParams}) async {
    final response = await dioConsumer.post(
      path: EndPoints.verifyUser,
      body: otpParams.toJson(),
    );
    String accessToken = response['data']['access_token'];
    UserModel userModel = UserModel.fromJson(response['data']['auth']);
    sharedPreferences.setBool(AppStrings.isGuest, false);
    UserDataService().setUserData(userModel);
    UserTypeService().setUserType(userModel.userType!);
    await tokenRepository.saveToken(accessToken);
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
    await sharedPreferences.clear();
  await  tokenRepository.deleteToken();
    await ApiConfig().init();
    return ApiSuccessResponse(message: response['result']);
  }

  @override
  Future<ApiSuccessResponse> loginUser({
    required String phone,
    required UserType userType,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.loginUser,
      body: {
        "phone": phone,
        "user_type": userType == UserType.delivery
            ? UserType.driver.name
            : userType.name,
        "driver_type": userType == UserType.driver
            ? "taxi_driver"
            : "delivery_driver",
      },
    );
    return ApiSuccessResponse(data: response['data']);
  }

  @override
  Future<ApiSuccessResponse> deleteUser({required int reason}) async {
    final response = await dioConsumer.delete(path: EndPoints.deleteUser);
    await sharedPreferences.clear();
    await  tokenRepository.deleteToken();
    await ApiConfig().init();
    return ApiSuccessResponse(message: response['result']);
  }

  @override
  Future<ApiSuccessResponse> resendOtp({
    required String phone,
    required UserType userType,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.verifyUser,
      body: {
        "phone": phone,
        "user_type": userType == UserType.delivery
            ? UserType.driver.name
            : userType.name,
      },
    );
    return ApiSuccessResponse();
  }

  @override
  Future<ApiSuccessResponse> updateFcm() async {
    final String? token = await FirebaseMessaging.instance.getToken();
    final response = await dioConsumer.post(
      path: EndPoints.updateFcm,
      body: {"device_token": token},
    );
    return ApiSuccessResponse();
  }
}
