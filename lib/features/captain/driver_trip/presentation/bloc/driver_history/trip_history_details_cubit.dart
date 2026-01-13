import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../../../core/services/location/map_helper.dart';
import '../../../../../../core/services/location/polyline_helper.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../gen/assets.gen.dart';

part 'trip_history_details_state.dart';

@Injectable()
class TripHistoryDetailsCubit extends Cubit<TripHistoryDetailsState> {
  final PolyLineHelper polyLineHelper;

  TripHistoryDetailsCubit(this.polyLineHelper)
    : super(TripHistoryDetailsInitial());

  Set<Marker> markers = {};
  Set<Polyline> polyines = {};

  Future<void> initPolyline({required TripModel tripModel}) async {
    final Uint8List? markerIcon = await MapHelper().getBytesFromAsset(
      path: Assets.images.origin.path,
      width: 50,
    );
    final Uint8List? markerIcon1 = await MapHelper().getBytesFromAsset(
      path: Assets.images.destination.path,
      width: 30,
    );

    markers.add(
      Marker(
        markerId: const MarkerId(AppStrings.origin),
        position: tripModel.from!.latLng,
        icon: BitmapDescriptor.bytes(markerIcon!),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId(AppStrings.destination),
        position: tripModel.to!.latLng,
        icon: BitmapDescriptor.bytes(markerIcon1!),
      ),
    );

    Polyline? polyLine = await polyLineHelper.getPolyLine(
      origin: tripModel.from!.latLng,
      destination: tripModel.to!.latLng,
      place: tripModel.to!.place,
    );
    if (polyLine != null) {
      polyines.add(polyLine);
    }
    emit(InitHistoryTripDetailsState());
  }
}
