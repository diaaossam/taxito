import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/features/captain/auth/data/models/request/otp_params.dart';
import 'package:taxito/core/data/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/config/helper/device_helper.dart';
import 'package:taxito/features/user/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:meta/meta.dart';

part 'otp_event.dart';

part 'otp_state.dart';

@injectable
class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final DeviceHelper deviceHelper;
  final VerifyOtpUseCase verifyOtpUseCase;

  OtpBloc(this.verifyOtpUseCase, this.deviceHelper) : super(OtpInitial()) {
    on<VerifyOtpCodeEvent>((event, emit) async {
      emit(VerifyOtpLoadingState());
      OtpParams otpParams = OtpParams(
        otp: event.otpCode,
        userType: event.userType,
        phoneNumber: event.phone,
        deviceToken: await deviceHelper.deviceToken,
        deviceType: deviceHelper.devicePlatform,
      );
      final response = await verifyOtpUseCase(otpParams: otpParams);
      emit(
        response.fold(
          (l) {
            print(l.msg);
            return VerifyOtpFailureState(errorMsg: l.msg);
          },
          (r) {
            return VerifyOtpSuccessState(userModel: r.data as UserModel);
          },
        ),
      );
    });
  }
}
