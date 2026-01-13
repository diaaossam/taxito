import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:taxito/features/common/models/orders.dart';
import '../../../domain/usecases/get_order_details_use_case.dart';

part 'track_order_state.dart';

@Injectable()
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetOrderDetailsUseCase getOrderDetailsUseCase;

  TrackOrderCubit(this.getOrderDetailsUseCase) : super(TrackOrderInitial());

  Orders? orders;

  Future<void> getOrderDetails({required num orderId}) async {
    emit(GetOrderDetailsLoading());
    final response = await getOrderDetailsUseCase(id: orderId.toInt());
    emit(
      response.fold((l) => GetOrderDetailsFailure(msg: l.msg), (r) {
        orders = r.data;
        return GetOrderDetailsSuccess(orders: r.data);
      }),
    );
  }
}
