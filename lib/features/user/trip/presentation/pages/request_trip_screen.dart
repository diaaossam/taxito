import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/dependencies/injectable_dependencies.dart';
import '../../data/models/trip_model.dart';
import '../bloc/accepted_user_trip/accepted_user_trip_cubit.dart';
import '../bloc/request_trip/request_trip_info_bloc.dart';
import '../bloc/trip_info/trip_bloc.dart';
import '../bloc/trip_rating/trip_rating_bloc.dart';
import '../widgets/trip_body.dart';

class RequestTripScreen extends StatelessWidget {
  final TripModel? tripModel;

  const RequestTripScreen({
    super.key,
    this.tripModel,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<TripBloc>()..getCurrentLocation(),
          ),
          BlocProvider(
            create: (context) => sl<AcceptedUserTripCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<RequestTripBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<TripRatingBloc>(),
          ),
        ],
        child: Scaffold(
          body: SafeArea(
              child: TripBody(
            tripModel: tripModel,
          )),
        ));
  }
}
