import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/app_size.dart';
import '../../../../widgets/loading/loading_widget.dart';
import '../cubit/location_picker/location_picker_cubit.dart';
import '../cubit/location_picker/location_picker_state.dart';

class AddLocationMap extends StatelessWidget {
  final MyAddress? address;
  const AddLocationMap({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationPickerCubit, LocationPickerState>(
      builder: (context, state) {
        final bloc = context.read<LocationPickerCubit>();
        if (bloc.currentLocation == null) {
          return const LoadingWidget();
        } else {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colorScheme.primary,width: 2)
              ),
              height: SizeConfig.bodyHeight * .23,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  buildingsEnabled: true,
                  mapToolbarEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: {
                    Marker(
                      markerId: const MarkerId("moving_marker"),
                      position: bloc.currentLocation!,
                    ),
                  },
                  onTap: (p0) => bloc.changeLocation(value: p0),
                  onCameraMove: (p0) => bloc.changeLocation(value: p0.target),
                  initialCameraPosition:
                      CameraPosition(target: bloc.currentLocation!, zoom: 14),
                ),
              ));
        }
      },
    );
  }
}
