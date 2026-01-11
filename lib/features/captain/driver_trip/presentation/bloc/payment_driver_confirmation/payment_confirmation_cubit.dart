import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/services/socket/socket.dart';
import '../../../domain/usecases/accept_driver_payment_request_use_case.dart';

part 'payment_confirmation_state.dart';

@Injectable()
class PaymentConfirmationCubit extends Cubit<PaymentConfirmationState> {
  final SocketService socketService;
  final AcceptDriverPaymentRequestUseCase acceptDriverPaymentRequestUseCase;
  String tripValue = "";

  PaymentConfirmationCubit(
      this.socketService, this.acceptDriverPaymentRequestUseCase)
      : super(PaymentConfirmationInitial());

  Future<void> acceptPaymentRequest(
      {required String tripId,
      required num id,
      required bool driverAcceptConfirmation}) async {
    emit(AcceptPaymentRequestLoading());
    final response = await acceptDriverPaymentRequestUseCase(
        id: id, driverAcceptConfirmation: driverAcceptConfirmation);
    emit(response.fold(
      (l) => AcceptPaymentRequestFailure(msg: l.msg),
      (r) {
        socketService.emitEvent("payment-confirmation", {
          "tripId": tripId,
          "trip": r.response,
        });
        return AcceptPaymentRequestSuccess();
      },
    ));
  }

  @override
  Future<void> close() {
    socketService.disconnectFromRoom("");
    return super.close();
  }
}
