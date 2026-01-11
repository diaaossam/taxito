import 'dart:async';
import 'dart:math' as Math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationManager {
  static final LocationManager singleton = LocationManager._internal();

  LocationManager._internal();

  static LocationManager get shared => singleton;

  Position? currentPos;
  double carDegree = 0.0;

  void initLocation() {
    getLocationUpdates();
  }

  getLocationUpdates() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint(" Location service are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint(" Location service are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
          " Location permission are permanently denied, we cannot request permission");
      return;
    }

    const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 8);

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      carDegree = calculateDegrees(
          LatLng(currentPos?.latitude ?? 0.0, currentPos?.longitude ?? 0.0),
          LatLng(position.latitude, position.longitude));
      currentPos = position;

    });
  }

  static double calculateDegrees(LatLng startPoint, LatLng endPoint) {
    final double startLat = toRadians(startPoint.latitude);
    final double startLng = toRadians(startPoint.longitude);
    final double endLat = toRadians(endPoint.latitude);
    final double endLng = toRadians(endPoint.longitude);

    final double deltaLng = endLng - startLng;

    final double y = Math.sin(deltaLng) * Math.cos(endLat);
    final double x = Math.cos(startLat) * Math.sin(endLat) -
        Math.sin(startLat) * Math.cos(endLat) * Math.cos(deltaLng);

    final double bearing = Math.atan2(y, x);
    return (toDegrees(bearing) + 360) % 360;
  }

  static double toRadians(double degrees) {
    return degrees * (Math.pi / 180.0);
  }

  static double toDegrees(double radians) {
    return radians * (180.0 / Math.pi);
  }

  static String calculateDistance(LatLng startPoint, LatLng endPoint) {
    final double lat1 = startPoint.latitude;
    final double lon1 = startPoint.longitude;
    final double lat2 = endPoint.latitude;
    final double lon2 = endPoint.longitude;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    var radiusOfEarth = 6371;
    return (radiusOfEarth * 2 * asin(sqrt(a))).toStringAsFixed(2);
  }

  static Future<String> getMyAddress({required LatLng latLng}) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      return "${placemarks.first.country} ${placemarks.first.administrativeArea}";
    } catch (error) {
      return "";
    }
  }
}
