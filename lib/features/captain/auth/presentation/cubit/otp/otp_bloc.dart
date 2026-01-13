import 'package:taxito/core/enum/user_type.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../config/helper/device_helper.dart';
import '../../../data/models/request/otp_params.dart';
import 'package:taxito/features/common/models/user_model.dart';
import '../../../domain/usecases/resend_otp_use_case.dart';
import '../../../domain/usecases/verify_otp_use_case.dart';

part 'otp_event.dart';

part 'otp_state.dart';

@injectable
class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final DeviceHelper deviceHelper;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  OtpBloc(this.verifyOtpUseCase, this.deviceHelper, this.resendOtpUseCase)
    : super(OtpInitial()) {
    on<VerifyOtpCodeEvent>((event, emit) async {
      emit(VerifyOtpLoadingState());
      OtpParams otpParams = OtpParams(
        otp: event.otpCode,
        phoneNumber: event.phone,
        userType: event.userType,
        deviceToken: await deviceHelper.deviceToken,
        deviceType: deviceHelper.devicePlatform,
      );
      final response = await verifyOtpUseCase(otpParams: otpParams);
      emit(
        response.fold((l) => VerifyOtpFailureState(errorMsg: l.msg), (r) {
          return VerifyOtpSuccessState(data: r.data);
        }),
      );
    });
    on<ResendOtpCodeEvent>((event, emit) async {
      emit(ResendOtpLoadingState());
      final response = await resendOtpUseCase(
        phone: event.phone,
        userType: event.userType,
      );
      emit(
        response.fold(
          (l) => ResendOtpFailureState(errorMsg: l.msg),
          (r) => ResendOtpSuccessState(),
        ),
      );
    });
  }
}
