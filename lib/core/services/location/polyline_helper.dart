import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/config/environment/environment_helper.dart' as env;

@Injectable()
class PolyLineHelper {
  PolyLineHelper();

  Future<Polyline?> getPolyLine({
    required LatLng origin,
    required LatLng destination,
    required String place,
  }) async {
    try {
      final url =
          "https://api.mapbox.com/directions/v5/mapbox/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?geometries=polyline&overview=full&access_token=${env.Environment.googleApiKey}";

      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        final route = data["routes"][0];
        final geometry = route["geometry"];

        // polyline string
        String encodedPolyline = geometry;

        // فك ترميز ال polyline
        List<PointLatLng> result =
            PolylinePoints.decodePolyline(encodedPolyline);

        List<LatLng> polylineCoordinates = result
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        return Polyline(
          polylineId: const PolylineId("trip"),
          color: Colors.blue,
          width: 7,
          points: polylineCoordinates,
        );
      } else {
        if (kDebugMode) {
          print("Mapbox Directions error: ${response.data}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
    return null;
  }
}
