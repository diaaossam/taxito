import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  final LatLng latLng;
  final Set<Marker>? markers;
  final Function(CameraPosition)? onCameraMove;
  final Set<Polyline>? polylines;
  final Function(GoogleMapController)? onMapCreated;
  final Function(LatLng)? onTap;
  final bool myLocationEnabled;

  const GoogleMapWidget({
    super.key,
    required this.latLng,
    this.markers,
    this.myLocationEnabled = true,
    this.onMapCreated,
    this.polylines,
    this.onCameraMove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: latLng, zoom: 14),
      zoomGesturesEnabled: true,
      onMapCreated: onMapCreated,
      markers: markers ?? {},
      onTap: onTap,
      onCameraMove: onCameraMove,
      polylines: polylines ?? {},
      zoomControlsEnabled: true,
      myLocationEnabled: false,
      myLocationButtonEnabled: myLocationEnabled,
    );
  }
}
