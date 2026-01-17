import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:taxito/core/services/socket/socket.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/features/common/models/orders.dart';
import 'package:taxito/features/user/order/domain/usecases/delete_order_use_case.dart';
import 'package:taxito/features/user/order/domain/usecases/get_order_details_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../config/helper/token_repository.dart';

part 'track_order_state.dart';

@Injectable()
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final DeleteOrderUseCase deleteOrderUseCase;
  final SocketService socketService;
  final TokenRepository tokenRepository;

  TrackOrderCubit(
    this.getOrderDetailsUseCase,
    this.deleteOrderUseCase, {
    required this.socketService,
    required this.tokenRepository,
  }) : super(TrackOrderInitial());

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

  Future<void> deleteOrder({required num orderId}) async {
    emit(DeleteOrderLoading(id: orderId));
    final response = await deleteOrderUseCase(id: orderId.toInt());
    emit(
      response.fold((l) => DeleteOrderFailure(msg: l.msg), (r) {
        return DeleteOrderSuccess(msg: r.message ?? "", id: orderId);
      }),
    );
  }

  Map<String, Marker> markers = {};
  LatLng? currentLatLng;
  Set<Polyline> polyines = {};

  Future<void> trackOrder({required Orders orders}) async {
    socketService.emitEvent("addUserToOrder", {"orderId": orders.id});
    socketService.onEvent("updating-order.${orders.id}", (data) {
      Logger().w("$data");
    });

    /*    LatLng newLatLng = LatLng(lat, long);
    socketService.emitEvent("update-status", {
      "driverId": UserDataService().getUserData()?.id,
      "isOnline": true,
      "hasTrip": false,
      "location": {
        "lat": lat,
        "lng": long,
      },
    });
    if (currentLatLng != null && newLatLng != currentLatLng) {
      double rotation = LocationPermissionService().calculateCarDegree(currentLatLng!, newLatLng);
      currentLatLng = newLatLng;
      markers['car'] = Marker(
        markerId: const MarkerId("car"),
        position: newLatLng,
        icon: icon ?? BitmapDescriptor.defaultMarker,
        rotation: rotation,
        anchor: const Offset(0.5, 0.5),
      );
      emit(UpdateDriverLocationState(lat: lat, lon: long));
    }
    else {
      currentLatLng = newLatLng;
    }*/
  }


}
