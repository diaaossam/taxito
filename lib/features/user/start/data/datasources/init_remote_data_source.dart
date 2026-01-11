import 'package:aslol/config/helper/token_repository.dart';
import 'package:aslol/core/enum/trip_status_enum.dart';
import 'package:aslol/features/auth/data/models/response/user_model.dart';
import 'package:aslol/features/auth/presentation/pages/login_screen.dart';
import 'package:aslol/features/location/presentation/pages/auth_location_screen.dart';
import 'package:aslol/features/main/presentation/pages/main_layout.dart';
import 'package:aslol/features/start/presentation/pages/on_boarding_screen.dart';
import 'package:aslol/features/trip/presentation/pages/request_trip_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/dio_consumer.dart';
import 'package:aslol/core/services/network/end_points.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/core/utils/app_strings.dart';
import 'package:aslol/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:aslol/features/start/data/models/intro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/api_config.dart';
import '../../../auth/data/models/response/user_model_helper.dart';
import '../../../trip/data/models/trip_model.dart';

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
    final hasToken = await tokenRepository.hasToken();
    if (onBoarding != null) {
      if (!hasToken) {
        return ApiSuccessResponse(data: const LoginScreen());
      } else {
        final response = await authRemoteDataSource.getUserData();
        if (response.data == null) {
          return ApiSuccessResponse(data: const LoginScreen());
        }
        UserModel userModel = response.data;
        UserDataService().setUserData(userModel);
        await ApiConfig().init();
        if (userModel.isProfileCompleted == 0) {
          return ApiSuccessResponse(data: const LoginScreen());
        }
        if (userModel.isProfileCompleted == 1 &&
            userModel.currentAddress == null) {
          return ApiSuccessResponse(data: const AuthLocationScreen());
        }
        UserDataService().setUserData(userModel);
        await ApiConfig().init();
        ///////////// Start Trip Check /////////////
        if (userModel.tripModel != null) {
          TripModel tripModel = userModel.tripModel!;
          if (tripModel.driver != null) {
            if (tripModel.userSentRequestConfirmPayment == 1 &&
                tripModel.driverAcceptConfirmation == 1) {
              return ApiSuccessResponse(data: const MainLayout());
            } else {
              return ApiSuccessResponse(
                data: RequestTripScreen(tripModel: tripModel),
              );
            }
          } else {
            if (tripModel.status == TripStatusEnum.waitingDriver) {
              return ApiSuccessResponse(
                data: RequestTripScreen(tripModel: tripModel),
              );
            }
            return ApiSuccessResponse(data: const MainLayout());
          }
        } else {
          return ApiSuccessResponse(data: const MainLayout());
        }
      }
    } else {
      return ApiSuccessResponse(data: const OnBoardingScreen());
    }
  }
}
