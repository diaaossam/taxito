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
  final VoidCallback? myLocationCallback;

  const GoogleMapWidget({
    super.key,
    required this.latLng,
    this.markers,
    this.myLocationEnabled = true,
    this.onMapCreated,
    this.polylines,
    this.onCameraMove,
    this.onTap,
    this.myLocationCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
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
          ),
          Positioned(
            bottom: 100,
            child: InkWell(
              onTap: myLocationCallback,
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsetsDirectional.only(start: 10),
                decoration:
                    BoxDecoration(color: Colors.white.withValues(alpha: 0.9)),
                child: const Icon(Icons.my_location),
              ),
            ),
          )
        ],
      ),
    );
  }
}
