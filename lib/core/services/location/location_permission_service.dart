import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:open_settings_plus/open_settings_plus.dart';

import '../../../gen/assets.gen.dart';

enum LocationPermissionStatus {
  granted,
  denied,
  deniedForever,
  serviceDisabled,
}

class LocationResult {
  final LatLng? location;
  final LocationPermissionStatus status;

  LocationResult({this.location, required this.status});
}

class LocationPermissionService {
  Future<LocationResult> requestPermissionAndLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.Location location = loc.Location();

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return LocationResult(
          location: null,
          status: LocationPermissionStatus.serviceDisabled,
        );
      }
    }

    // Check permission status
    permissionGranted = await location.hasPermission();

    // If denied, request permission
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      // If still denied after request
      if (permissionGranted == loc.PermissionStatus.denied) {
        return LocationResult(
          location: null,
          status: LocationPermissionStatus.denied,
        );
      }

      // If denied forever
      if (permissionGranted == loc.PermissionStatus.deniedForever) {
        return LocationResult(
          location: null,
          status: LocationPermissionStatus.deniedForever,
        );
      }
    }

    // If permission was already denied forever
    if (permissionGranted == loc.PermissionStatus.deniedForever) {
      return LocationResult(
        location: null,
        status: LocationPermissionStatus.deniedForever,
      );
    }

    // Get location
    try {
      if (Platform.isAndroid) {
        loc.LocationData locationData = await location.getLocation();
        return LocationResult(
          location: LatLng(
            locationData.latitude ?? 0.0,
            locationData.longitude ?? 0.0,
          ),
          status: LocationPermissionStatus.granted,
        );
      } else {
        geo.Position position = await geo.Geolocator.getCurrentPosition(
          locationSettings: const geo.LocationSettings(
            accuracy: geo.LocationAccuracy.high,
          ),
        );
        return LocationResult(
          location: LatLng(position.latitude, position.longitude),
          status: LocationPermissionStatus.granted,
        );
      }
    } catch (e) {
      return LocationResult(
        location: null,
        status: LocationPermissionStatus.denied,
      );
    }
  }

  /// Opens app settings to allow user to manually enable location permission
  Future<void> openLocationSettings() async {
    try {
      if (Platform.isAndroid) {
        await const OpenSettingsPlusAndroid().appSettings();
      } else {
        await const OpenSettingsPlusIOS().appSettings();
      }
    } catch (e) {
      // Handle error silently
    }
  }

  static Future<BitmapDescriptor> initIcon() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(devicePixelRatio: 3.2),
      width: 60,
      Assets.images.car.path,
      height: 60,
    );
  }

  static Future<String> getMyAddress({required LatLng latLng}) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      return "${placemarks.first.country} ${placemarks.first.administrativeArea}";
    } catch (error) {
      return "";
    }
  }

  double calculateCarDegree(LatLng oldPosition, LatLng newPosition) {
    double lat1 = oldPosition.latitude * (pi / 180);
    double lon1 = oldPosition.longitude * (pi / 180);
    double lat2 = newPosition.latitude * (pi / 180);
    double lon2 = newPosition.longitude * (pi / 180);

    double dLon = lon2 - lon1;

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    double bearing = atan2(y, x) * (180 / pi);

    return (bearing + 360) % 360;
  }
}
