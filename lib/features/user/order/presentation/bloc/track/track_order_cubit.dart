import 'package:aslol/features/order/data/models/orders.dart';
import 'package:aslol/features/order/domain/usecases/delete_order_use_case.dart';
import 'package:aslol/features/order/domain/usecases/get_order_details_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'track_order_state.dart';

@Injectable()
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final DeleteOrderUseCase deleteOrderUseCase;

  TrackOrderCubit(this.getOrderDetailsUseCase, this.deleteOrderUseCase)
      : super(TrackOrderInitial());

  Orders? orders;

  Future<void> getOrderDetails({required num orderId}) async {
    emit(GetOrderDetailsLoading());
    final response = await getOrderDetailsUseCase(id: orderId.toInt());
    emit(response.fold(
      (l) => GetOrderDetailsFailure(msg: l.msg),
      (r) {
        orders = r.data;
        return GetOrderDetailsSuccess(orders: r.data);
      },
    ));
  }

  Future<void> deleteOrder({required num orderId}) async {
    emit(DeleteOrderLoading(id: orderId));
    final response = await deleteOrderUseCase(id: orderId.toInt());
    emit(response.fold(
      (l) => DeleteOrderFailure(msg: l.msg),
      (r) {
        return DeleteOrderSuccess(msg: r.message ?? "", id: orderId);
      },
    ));
  }
}
