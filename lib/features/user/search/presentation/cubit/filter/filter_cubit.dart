import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/main/data/models/banners_model.dart';
import 'package:taxito/features/user/main/domain/usecases/get_main_category_use_case.dart';
import 'package:taxito/features/user/order/data/models/product_params.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/services/network/error/failures.dart';

part 'filter_state.dart';

@Injectable()
class FilterCubit extends Cubit<FilterState> {
  final GetMainCategoryUseCase getMainCategoryUseCase;

  FilterCubit(this.getMainCategoryUseCase) : super(FilterInitial()) {
    _getAllFilters();
  }

  ProductParams params = const ProductParams(pageKey: 1);
  List<BannersModel> mainCategories = [];

  Future<void> _getAllFilters() async {
    emit(FilterLoading());
    try {
      final results = await Future.wait([getMainCategoryUseCase()]);
      mainCategories = extractOrThrow(results[0]);
      emit(FilterLoaded(mainCategories: mainCategories));
    } catch (e) {
      emit(FilterFailure(msg: e.toString()));
    }
  }

  T extractOrThrow<T>(Either<Failure, ApiSuccessResponse> either) {
    final data = either.fold(
      (failure) => throw Exception(failure.msg),
      (response) => response.data!,
    );
    return data;
  }

  void updateFilterParams({required ProductParams updatedParams}) {
    params = updatedParams;
    emit(UpdateFilterParamsState());
  }
}
