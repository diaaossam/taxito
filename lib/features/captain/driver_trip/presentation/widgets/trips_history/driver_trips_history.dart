import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../../core/data/models/trip_model.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/loading/loading_widget.dart';
import '../../bloc/trip_history/trip_history_cubit.dart';
import 'driver_trip_item.dart';
import 'empty_trips_history.dart';

class DriverTripsHistory extends StatefulWidget {
  final String status;
  final PagingController<int, TripModel> pagingController;

  const DriverTripsHistory({
    super.key,
    required this.status,
    required this.pagingController,
  });

  @override
  State<DriverTripsHistory> createState() => _DriverTripsHistoryState();
}

class _DriverTripsHistoryState extends State<DriverTripsHistory> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<TripHistoryCubit>();
    widget.pagingController.addPageRequestListener((pageKey) {
      bloc.fetchPage(pageKey, widget.status, widget.pagingController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: screenPadding(),
      sliver: PagedSliverList(
        pagingController: widget.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
          noItemsFoundIndicatorBuilder: (context) =>
              const EmptyTripsHistoryWidget(),
          itemBuilder: (context, TripModel item, index) => DriverTripItem(
            tripModel: item,
            status: widget.status,
            isDriver: true,
          ),
        ),
      ),
    );
  }
}
