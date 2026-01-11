import 'package:aslol/core/enum/payment_type.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/services/socket/socket.dart';
import '../../../domain/usecases/send_payment_request_use_case.dart';

part 'trip_payment_user_state.dart';

@Injectable()
class TripPaymentUserCubit extends Cubit<TripPaymentUserState> {
  final SocketService socketService;
  final SendUserPaymentRequestUseCase sendUserPaymentRequestUseCase;
  String tripIdValue = "";
  int currentPaymentState = 0;

  TripPaymentUserCubit(this.socketService, this.sendUserPaymentRequestUseCase)
      : super(TripPaymentUserInitial());

  void initSocket({required String tripId}) {
    tripIdValue = tripId;
    socketService.onEvent(
      "payment-confirmation.$tripId",
          (event) {
        currentPaymentState = 2;
        emit(DriverSendConfirmPaymentState());
      },
    );
  }


  void sendPaymentRequestToDriver(
      {required String tripId,
      required num id,
      required PaymentType paymentMethod}) async {
    tripIdValue = tripId;
    emit(SendPaymentRequestLoading());
    final response = await sendUserPaymentRequestUseCase(
        id: id, paymentMethod: paymentMethod.name);
    emit(response.fold(
      (l) => SendPaymentRequestFailure(msg: l.msg),
      (r) {
        currentPaymentState = 1;
        socketService.emitEvent("payment-confirmation", {
          "tripId": tripId,
        });
        return SendPaymentRequestSuccess();
      },
    ));
  }

  @override
  Future<void> close() {
    socketService.disconnectFromRoom("updating-trip.$tripIdValue");
    socketService.disconnectFromRoom("addUserToTrip");
    socketService.disconnectFromRoom("update-trip-status.$tripIdValue");
    socketService.disconnectFromRoom("payment-confirmation.$tripIdValue");
    return super.close();
  }
}
