import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:taxito/core/services/location/driver_location_tracking_service.dart';
import 'package:taxito/features/common/models/orders.dart';

part 'delivery_location_state.dart';

@Injectable()
class DeliveryLocationCubit extends Cubit<DeliveryLocationState> {
  final DriverLocationTrackingService _locationTrackingService;

  DeliveryLocationCubit(this._locationTrackingService) 
      : super(DeliveryLocationInitial());

  /// Start tracking driver location for an order
  /// This uses the app-wide tracking service, so location updates
  /// will continue even when navigating away from the current screen
  Future<void> startTrackingOrder({required Orders order}) async {
    emit(GetCurrentLocationLoadingState());
    try {
      await _locationTrackingService.startTracking(order: order);
      
      if (!isClosed) {
        emit(GetCurrentLocationSuccessState());
      }
    } catch (error) {
      if (!isClosed) {
        emit(GetCurrentLocationFailureState(errorMsg: error.toString()));
      }
    }
  }

  /// Stop tracking driver location
  Future<void> stopTrackingOrder() async {
    try {
      await _locationTrackingService.stopTracking();
    } catch (error) {
      // Handle error silently
    }
  }

  /// Update order details while tracking
  void updateTrackedOrder(Orders order) {
    _locationTrackingService.updateOrder(order);
  }

  /// Get current tracking status
  bool get isTracking => _locationTrackingService.isTracking;

  /// Get current order being tracked
  Orders? get currentOrder => _locationTrackingService.currentOrder;

  /// Get last known position
  Position? get lastKnownPosition => _locationTrackingService.getLastKnownPosition();

  /// Legacy method for backward compatibility
  /// @deprecated Use [startTrackingOrder] instead
  @Deprecated('Use startTrackingOrder instead')
  Future<void> getDriverStreamLocation({required Orders order}) async {
    await startTrackingOrder(order: order);
  }

  @override
  Future<void> close() {
    // Don't stop tracking when cubit closes - tracking is app-wide
    // Only stop tracking when explicitly requested via stopTrackingOrder()
    return super.close();
  }
}
