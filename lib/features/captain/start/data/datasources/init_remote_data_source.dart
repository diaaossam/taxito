import 'package:taxito/config/helper/token_repository.dart';
import 'package:taxito/features/captain/auth/data/models/response/user_model.dart';
import 'package:taxito/features/captain/delivery_main/presentation/pages/delivery_main_layout.dart';
import 'package:taxito/features/captain/start/presentation/pages/on_boarding_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:taxito/features/captain/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taxito/features/captain/start/data/models/intro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utils/api_config.dart';
import '../../../auth/data/models/response/user_model_helper.dart';
import '../../../auth/presentation/pages/driver_register.dart';
import '../../../driver_main/presentation/pages/driver_main_layout.dart';
import '../../../driver_trip/data/models/trip_model.dart';
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

  RegisterRemoteDataSourceImpl(
      {required this.dioConsumer,
      required this.sharedPreferences,
      required this.tokenRepository,
      required this.authRemoteDataSource});

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
        return ApiSuccessResponse(data: const WelcomeScreen());
      }
      else {
        final response = await authRemoteDataSource.getUserData();
        if (response.data == null) {
          return ApiSuccessResponse(data: const WelcomeScreen());
        }
        UserModel userModel = response.data;
        UserDataService().setUserData(userModel);
        await ApiConfig().init();
        if (userModel.driverType == "delivery_driver") {
          if(userModel.isProfileCompleted == 1){
            return ApiSuccessResponse(data: const DeliveryMainLayout());
          }else{
            return ApiSuccessResponse(
                data: RegisterScreen(
                  phone: userModel.phone.toString(),
                  isUpdate: false,
                ));
          }
        }
        else {
          if (userModel.isProfileCompleted == 1) {
            if (userModel.tripModel != null) {
              TripModel tripModel = userModel.tripModel!;
              if (tripModel.userSentRequestConfirmPayment == 1 && tripModel.driverAcceptConfirmation == 1) {
                return ApiSuccessResponse(data: const DriverMainLayout());
              } else {
                return ApiSuccessResponse(
                    data: DriverMainLayout(
                      tripModel: tripModel,
                    ));
              }
            }
            else{
              return ApiSuccessResponse(data: const DriverMainLayout());
            }
          }
          else {
            return ApiSuccessResponse(
                data: RegisterScreen(
                  phone: userModel.phone.toString(),
                  isUpdate: false,
                ));
          }
        }
      }
    } else {
      return ApiSuccessResponse(data: const OnBoardingScreen());
    }
  }
}
