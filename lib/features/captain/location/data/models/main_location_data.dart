import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainLocationData extends Equatable {
  final String address;
  final String place;
  final LatLng latLng;

  const MainLocationData(
      {required this.address, required this.latLng, required this.place});

  factory MainLocationData.fromJson(dynamic json) => MainLocationData(
      address: json['address'],
      latLng: LatLng(json['latitude'], json['longitude']),
      place: json['address']);

  Map<String, dynamic> toJson() => {
        "address": address,
        "longitude": latLng.longitude,
        "latitude": latLng.latitude,
        "place": place,
      };

  @override
  List<Object> get props => [address, latLng, place];
}
