import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:aslol/features/location/presentation/cubit/add_new_address/add_new_address_cubit.dart';
import 'package:aslol/features/location/presentation/cubit/globale_location/global_location_cubit.dart';
import 'package:aslol/features/location/presentation/widgets/add_new_address_body.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';
import '../cubit/location_picker/location_picker_cubit.dart';

class AddAddressScreen extends StatelessWidget {
  final MyAddress? address;

  const AddAddressScreen({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<GlobalLocationCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<AddNewAddressCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<LocationPickerCubit>()..initLocationService(initAddress: address),
          ),
        ],
        child: Scaffold(
          appBar: CustomAppBar(
            title: context.localizations.addNewAddress,
          ),
          body: AddNewAddressBody(
            address: address,
          ),
        ));
  }
}
