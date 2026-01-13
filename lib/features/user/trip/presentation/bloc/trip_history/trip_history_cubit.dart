import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/data/models/trip_model.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../domain/usecases/get_all_trips_history_use_case.dart';

part 'trip_history_state.dart';

@Injectable()
class TripHistoryCubit extends Cubit<TripHistoryState> {
  final GetAllTripsHistoryUseCase getAllTripsHistoryUseCase;
  final PagingController<int, TripModel> deliveredPagingController =
      PagingController(firstPageKey: 0);
  final PagingController<int, TripModel> cancelledPagingController =
      PagingController(firstPageKey: 0);
  final PagingController<int, TripModel> commingPagingController =
      PagingController(firstPageKey: 0);

  TripHistoryCubit(this.getAllTripsHistoryUseCase)
    : super(TripHistoryInitial());

  Future<void> fetchPage(
    int pageKey,
    String status,
    PagingController<int, TripModel> pagingController,
    bool isSch,
  ) async {
    try {
      final List<TripModel> newItems = await _getAllTrips(
        pageKey: pageKey,
        status: status,
        isSch: isSch,
      );
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<TripModel>> _getAllTrips({
    required int pageKey,
    required String status,
    required bool isSch,
  }) async {
    List<TripModel> trips = [];
    final response = await getAllTripsHistoryUseCase(
      status: status,
      pageKey: pageKey,
      isSch: isSch,
    );
    response.fold(
      (l) {
        trips = [];
      },
      (r) {
        trips = r.data;
      },
    );
    return trips;
  }
}
