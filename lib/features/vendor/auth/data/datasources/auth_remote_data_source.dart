import 'package:taxito/config/helper/token_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../config/helper/device_helper.dart';
import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../../captain/app/data/models/generic_model.dart';
import '../../domain/entity/register_params.dart';
import '../models/response/user_model.dart';
import '../models/response/user_model_helper.dart';

abstract class AuthRemoteDataSource {
  Future<ApiSuccessResponse> registerUser({
    required RegisterParams registerParams,
  });

  Future<ApiSuccessResponse> loginUser({required String phone});

  Future<ApiSuccessResponse> getSupplierCategory();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioConsumer dioConsumer;
  final TokenRepository tokenRepository;
  final DeviceHelper deviceHelper;
  final SharedPreferences sharedPreferences;

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
          'profile_image',
          await MultipartFile.fromFile(registerParams.profileImage.toString()),
        ),
      );
      formData.files.add(
        MapEntry(
          'logo',
          await MultipartFile.fromFile(registerParams.profileImage.toString()),
        ),
      );
    }
    if (registerParams.coverImage != null &&
        !registerParams.coverImage!.contains("http")) {
      formData.files.add(
        MapEntry(
          'cover_image',
          await MultipartFile.fromFile(registerParams.coverImage.toString()),
        ),
      );
    }
    if (registerParams.commercialRegistration != null &&
        !registerParams.commercialRegistration!.contains("http")) {
      formData.files.add(
        MapEntry(
          'commercial_registration',
          await MultipartFile.fromFile(
            registerParams.commercialRegistration.toString(),
          ),
        ),
      );
    }
    final response = await dioConsumer.post(
      path: EndPoints.register,
      data: formData,
    );
    UserModel userModel = UserModel.fromJson(response['data']);
    UserDataService().setUserData(userModel);
    return ApiSuccessResponse();
  }

  @override
  Future<ApiSuccessResponse> loginUser({required String phone}) async {
    final response = await dioConsumer.post(
      path: EndPoints.loginUser,
      body: {"phone": phone, "user_type": "supplier"},
    );
    return ApiSuccessResponse(data: response['data']);
  }

  @override
  Future<ApiSuccessResponse> getSupplierCategory() async {
    final response = await dioConsumer.get(path: EndPoints.supplierCategories);
    final List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }
}
