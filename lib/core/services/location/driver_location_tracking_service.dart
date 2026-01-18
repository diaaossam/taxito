import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:taxito/core/services/socket/socket.dart';
import 'package:taxito/features/common/models/orders.dart';

/// Professional singleton service for app-wide driver location tracking
/// This service runs independently of any UI and continues tracking location
/// even when the user navigates between screens.
@lazySingleton
class DriverLocationTrackingService {
  final SocketService _socketService;
  final Logger _logger = Logger();

  DriverLocationTrackingService(this._socketService);

  // Location stream subscription
  StreamSubscription<Position>? _locationSubscription;
  
  // Backup timer for periodic updates
  Timer? _periodicUpdateTimer;
  
  // Current tracking state
  bool _isTracking = false;
  Orders? _currentOrder;
  Position? _lastKnownPosition;

  /// Check if tracking is currently active
  bool get isTracking => _isTracking;

  /// Get current order being tracked
  Orders? get currentOrder => _currentOrder;

  /// Start tracking driver location for a specific order
  /// This will continue tracking until [stopTracking] is called
  Future<void> startTracking({required Orders order}) async {
    try {
      // If already tracking the same order, no need to restart
      if (_isTracking && _currentOrder?.id == order.id) {
        _logger.i("📍 Already tracking order ${order.id}");
        return;
      }

      // Stop any existing tracking first
      if (_isTracking) {
        await stopTracking();
      }

      _logger.i("🚀 Starting location tracking for order ${order.id}");
      _currentOrder = order;
      _isTracking = true;

      // Request location permissions
      final hasPermission = await _checkLocationPermissions();
      if (!hasPermission) {
        _logger.e("❌ Location permissions denied");
        _isTracking = false;
        return;
      }

      // Start listening to location stream
      _startLocationStream();

      // Start periodic backup updates (every 1 minute)
      _startPeriodicUpdates();

      _logger.i("✅ Location tracking started successfully");
    } catch (error) {
      _logger.e("❌ Error starting location tracking: $error");
      _isTracking = false;
      rethrow;
    }
  }

  /// Stop tracking driver location
  Future<void> stopTracking() async {
    _logger.i("🛑 Stopping location tracking");
    
    _isTracking = false;
    _currentOrder = null;
    
    await _locationSubscription?.cancel();
    _locationSubscription = null;
    
    _periodicUpdateTimer?.cancel();
    _periodicUpdateTimer = null;

    _logger.i("✅ Location tracking stopped");
  }

  /// Update the order details without restarting tracking
  void updateOrder(Orders order) {
    if (_isTracking && _currentOrder?.id == order.id) {
      _currentOrder = order;
      _logger.i("🔄 Updated order details for ${order.id}");
      
      // Send immediate update with new order data
      if (_lastKnownPosition != null) {
        _emitLocationUpdate(_lastKnownPosition!);
      }
    }
  }

  /// Internal method to check and request location permissions
  Future<bool> _checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _logger.w("⚠️ Location services are disabled");
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _logger.w("⚠️ Location permissions denied");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _logger.w("⚠️ Location permissions permanently denied");
      return false;
    }

    return true;
  }

  /// Internal method to start location stream
  void _startLocationStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 8, // Update every 8 meters
    );


    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (Position position) {
        Logger().w("------=-=${position.latitude}");
        Logger().w("------=-=${position.longitude}");
        _lastKnownPosition = position;
        _emitLocationUpdate(position);
      },
      onError: (error) {
        _logger.e("❌ Location stream error: $error");
      },
      cancelOnError: false,
    );
  }

  /// Internal method to start periodic updates
  void _startPeriodicUpdates() {
    _periodicUpdateTimer?.cancel();
    _periodicUpdateTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) async {
        if (!_isTracking || _currentOrder == null) {
          timer.cancel();
          return;
        }

        try {
          Position position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.bestForNavigation,
            ),
          );
          _lastKnownPosition = position;
          _emitLocationUpdate(position);
        } catch (error) {
          _logger.e("❌ Periodic update error: $error");
        }
      },
    );
  }

  /// Internal method to emit location update via socket
  void _emitLocationUpdate(Position position) {
    if (!_isTracking || _currentOrder == null) {
      return;
    }

    try {
      final updateData = {
        "orderId": _currentOrder!.id,
        "order": _currentOrder!.toJson(),
        "driverLat": position.latitude,
        "driverLng": position.longitude,
      };

      _socketService.emitEvent("updating-order", updateData);
      
      _logger.d(
        "📍 Location update sent: Order ${_currentOrder!.id} - "
        "Lat: ${position.latitude.toStringAsFixed(6)}, "
        "Lng: ${position.longitude.toStringAsFixed(6)}",
      );
    } catch (error) {
      _logger.e("❌ Error emitting location update: $error");
    }
  }

  /// Get last known position (useful for UI)
  Position? getLastKnownPosition() => _lastKnownPosition;

  /// Dispose and cleanup all resources
  Future<void> dispose() async {
    _logger.i("🗑️ Disposing DriverLocationTrackingService");
    await stopTracking();
    _lastKnownPosition = null;
  }
}
