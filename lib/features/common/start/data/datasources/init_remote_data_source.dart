import 'package:taxito/config/helper/token_repository.dart';
import 'package:taxito/features/common/models/user_model.dart';
import 'package:taxito/features/common/models/user_type_helper.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/features/captain/delivery_main/presentation/pages/delivery_main_layout.dart';
import 'package:taxito/features/common/start/presentation/pages/on_boarding_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:taxito/features/captain/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taxito/features/common/start/data/models/intro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:taxito/features/vendor/main/presentation/pages/main_layout.dart';
import '../../../models/trip_model.dart';
import '../../../../../core/enum/trip_status_enum.dart';
import '../../../../../core/utils/api_config.dart';
import '../../../models/user_model_helper.dart';
import '../../../../captain/auth/presentation/pages/driver_register.dart';
import '../../../../captain/driver_main/presentation/pages/driver_main_layout.dart';
import '../../../../user/trip/presentation/pages/request_trip_screen.dart';
import '../../../../vendor/auth/presentation/pages/supplier_register.dart';
import '../../presentation/pages/welcome_screen.dart';

abstract class InitRemoteDataSource {
  Future<ApiSuccessResponse> getIntroData();

  Future<ApiSuccessResponse> initUser();
}

@LazySingleton(as: InitRemoteDataSource)
class RegisterRemoteDataSourceImpl implements InitRemoteDataSource {
  final DioConsumer dioConsumer;
  final SharedPreferences sharedPreferences;
  final TokenRepository tokenRepository;
  final AuthRemoteDataSource authRemoteDataSource;

  RegisterRemoteDataSourceImpl({
    required this.dioConsumer,
    required this.sharedPreferences,
    required this.tokenRepository,
    required this.authRemoteDataSource,
  });

  @override
  Future<ApiSuccessResponse> getIntroData() async {
    final response = await dioConsumer.get(path: EndPoints.introOnBoarding);
    final data = response['data']
        .map<IntroModel>((element) => IntroModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: data);
  }

  @override
  Future<ApiSuccessResponse> initUser() async {
    final onBoarding = sharedPreferences.getBool(AppStrings.onBoarding);
    if (onBoarding == null) {
      return ApiSuccessResponse(data: OnBoardingScreen());
    }

    final hasToken = await tokenRepository.hasToken();
    if (!hasToken) {
      return ApiSuccessResponse(data: WelcomeScreen());
    }

    final response = await authRemoteDataSource.getUserData();
    final userModel = response.data;
    if (userModel == null) {
      return ApiSuccessResponse(data: WelcomeScreen());
    }

    _initUserServices(userModel);

    switch (userModel.userType) {
      case UserType.supplier:
        return _handleSupplier(userModel);

      case UserType.user:
        return _handleNormalUser(userModel);

      default:
        return _handleDriver(userModel);
    }
  }

  void _initUserServices(UserModel userModel) async {
    UserDataService().setUserData(userModel);
    UserTypeService().setUserType(userModel.userType!);
    await ApiConfig().init();
  }

  ApiSuccessResponse _handleSupplier(UserModel userModel) {
    if (userModel.isProfileCompleted == 1) {
      return ApiSuccessResponse(data: SupplierMainLayout());
    }

    return ApiSuccessResponse(data: SupplierRegisterScreen(isUpdate: false));
  }

  ApiSuccessResponse _handleNormalUser(UserModel userModel) {
    final trip = userModel.userTripModel;

    if (trip == null) {
      return ApiSuccessResponse(data: MainLayout());
    }

    if (trip.driver != null) {
      if (_isTripConfirmed(trip)) {
        return ApiSuccessResponse(data: MainLayout());
      }

      return ApiSuccessResponse(data: RequestTripScreen(tripModel: trip));
    }

    if (trip.status == TripStatusEnum.waitingDriver) {
      return ApiSuccessResponse(data: RequestTripScreen(tripModel: trip));
    }

    return ApiSuccessResponse(data: MainLayout());
  }

  ApiSuccessResponse _handleDriver(UserModel userModel) {
    if (userModel.driverType == "delivery_driver") {
      return _handleDeliveryDriver(userModel);
    }

    return _handleCaptainDriver(userModel);
  }

  ApiSuccessResponse _handleDeliveryDriver(UserModel userModel) {
    if (userModel.isProfileCompleted == 1) {
      return ApiSuccessResponse(data: DeliveryMainLayout());
    }

    return ApiSuccessResponse(
      data: DriverRegisterScreen(
        phone: userModel.phone.toString(),
        isUpdate: false,
      ),
    );
  }

  bool _isTripConfirmed(TripModel trip) {
    return trip.userSentRequestConfirmPayment == 1 &&
        trip.driverAcceptConfirmation == 1;
  }

  ApiSuccessResponse _handleCaptainDriver(UserModel userModel) {
    if (userModel.isProfileCompleted != 1) {
      return ApiSuccessResponse(
        data: DriverRegisterScreen(
          phone: userModel.phone.toString(),
          isUpdate: false,
        ),
      );
    }

    final trip = userModel.tripModel;
    if (trip == null) {
      return  ApiSuccessResponse(data: DriverMainLayout());
    }

    if (_isTripConfirmed(trip)) {
      return  ApiSuccessResponse(data: DriverMainLayout());
    }

    return ApiSuccessResponse(
      data: DriverMainLayout(tripModel: trip),
    );
  }

}
