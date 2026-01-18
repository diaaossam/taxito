import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show Offset;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:taxito/core/services/socket/socket.dart';
import 'package:taxito/features/common/models/orders.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'live_map_tracking_state.dart';

@Injectable()
class LiveMapTrackingCubit extends Cubit<LiveMapTrackingState> {
  final SocketService socketService;

  LiveMapTrackingCubit(this.socketService) : super(LiveMapTrackingInitial());

  Orders? currentOrder;
  
  // Driver location tracking
  LatLng? driverLocation;
  LatLng? destinationLocation;
  Map<String, Marker> markers = {};
  Set<Polyline> polylines = {};
  GoogleMapController? mapController;
  
  // Animation properties
  Timer? _animationTimer;
  LatLng? _targetLocation;
  LatLng? currentAnimatedLocation;
  int _animationSteps = 20;
  int _currentStep = 0;
  double currentRotation = 0.0;

  /// Start tracking driver location via socket
  Future<void> startTracking({required Orders order}) async {
    currentOrder = order;
    
    // Set destination from order address
    if (order.address?.lat != null && order.address?.lng != null) {
      destinationLocation = LatLng(
        double.tryParse(order.address!.lat.toString()) ?? 0.0,
        double.tryParse(order.address!.lng.toString()) ?? 0.0,
      );
    }
    
    // Join the order room
    socketService.emitEvent("addUserToOrder", {"orderId": order.id});
    Logger().i("🚀 User started tracking driver for order ${order.id}");
    
    // Listen to driver location updates
    socketService.onEvent("updating-order.${order.id}", (data) {
      try {
        double lat = (data['driverLat'] as num).toDouble();
        double lng = (data['driverLng'] as num).toDouble();
        
        Logger().i("📍 User received driver location: $lat, $lng");
        
        _updateDriverLocation(lat, lng);
      } catch (e) {
        Logger().e("❌ Error parsing driver location: $e");
      }
    });
    
    // Initial marker setup
    _updateMarkers();
    emit(TrackingStarted());
  }

  /// Stop tracking driver location
  void stopTracking() {
    if (currentOrder?.id != null) {
      socketService.disconnectFromRoomEvent("updating-order.${currentOrder!.id}");
      Logger().i("🛑 User stopped tracking driver for order ${currentOrder!.id}");
    }
    _animationTimer?.cancel();
  }

  /// Update driver location with smooth animation
  void _updateDriverLocation(double lat, double lng) {
    final newLocation = LatLng(lat, lng);
    
    if (driverLocation == null) {
      // First location, no animation needed
      driverLocation = newLocation;
      currentAnimatedLocation = newLocation;
      _updateMarkers();
      _animateCamera();
      emit(DriverLocationUpdated(location: newLocation));
    } else {
      // Animate from current to new location
      _startLocationAnimation(newLocation);
    }
  }

  /// Smooth animation for driver marker movement
  void _startLocationAnimation(LatLng targetLocation) {
    _animationTimer?.cancel();
    _targetLocation = targetLocation;
    _currentStep = 0;
    
    final startLocation = currentAnimatedLocation ?? driverLocation!;
    
    // Calculate rotation before animation starts
    _calculateRotation(startLocation, targetLocation);
    
    _animationTimer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (_currentStep >= _animationSteps) {
          timer.cancel();
          driverLocation = _targetLocation;
          currentAnimatedLocation = _targetLocation;
          _updateMarkers();
          emit(DriverLocationUpdated(location: _targetLocation!));
          return;
        }
        
        _currentStep++;
        final progress = _currentStep / _animationSteps;
        
        // Linear interpolation
        final lat = startLocation.latitude + 
            (targetLocation.latitude - startLocation.latitude) * progress;
        final lng = startLocation.longitude + 
            (targetLocation.longitude - startLocation.longitude) * progress;
        
        currentAnimatedLocation = LatLng(lat, lng);
        _updateMarkers();
        emit(DriverLocationAnimating(location: currentAnimatedLocation!));
      },
    );
  }

  void _updateMarkers() {
    markers.clear();
    if (currentAnimatedLocation != null) {
      markers['driver'] = Marker(
        markerId: const MarkerId('driver'),
        position: currentAnimatedLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        anchor: const Offset(0.5, 0.5),
        rotation: currentRotation,
        infoWindow: const InfoWindow(title: '🚗 Driver'),
      );
    }
    
    // Destination marker
    if (destinationLocation != null) {
      markers['destination'] = Marker(
        markerId: const MarkerId('destination'),
        position: destinationLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: '📍 Delivery Location',
          snippet: currentOrder?.address?.address ?? '',
        ),
      );
    }
    
    emit(MarkersUpdated(markers: markers.values.toSet()));
  }

  /// Calculate rotation angle for driver marker
  void _calculateRotation(LatLng start, LatLng end) {
    final dLng = end.longitude - start.longitude;
    final y = dLng;
    final x = end.latitude - start.latitude;
    
    currentRotation = (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }

  /// Animate camera to show both driver and destination
  void _animateCamera() {
    if (mapController == null) return;
    
    if (driverLocation != null && destinationLocation != null) {
      // Calculate bounds to show both markers
      LatLngBounds bounds = _createBounds([driverLocation!, destinationLocation!]);
      mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100),
      );
    } else if (driverLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(driverLocation!, 15),
      );
    } else if (destinationLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(destinationLocation!, 15),
      );
    }
  }

  /// Create bounds for multiple locations
  LatLngBounds _createBounds(List<LatLng> positions) {
    double? south, north, east, west;
    
    for (var position in positions) {
      south = south == null ? position.latitude : math.min(south, position.latitude);
      north = north == null ? position.latitude : math.max(north, position.latitude);
      west = west == null ? position.longitude : math.min(west, position.longitude);
      east = east == null ? position.longitude : math.max(east, position.longitude);
    }
    
    return LatLngBounds(
      southwest: LatLng(south!, west!),
      northeast: LatLng(north!, east!),
    );
  }

  /// Set map controller
  void setMapController(GoogleMapController controller) {
    mapController = controller;
    _animateCamera();
  }



  @override
  Future<void> close() {
    stopTracking();
    _animationTimer?.cancel();
    mapController?.dispose();
    return super.close();
  }
}
