import 'package:aslol/features/main/data/models/banners_model.dart';
import 'package:aslol/features/main/domain/usecases/get_banners_use_case.dart';
import 'package:aslol/features/main/domain/usecases/get_main_category_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'banners_state.dart';

@Injectable()
class BannersCubit extends Cubit<BannersState> {
  final GetBannersUseCase _getBannersUseCase;
  final GetMainCategoryUseCase getMainCategoryUseCase;

  BannersCubit(this._getBannersUseCase, this.getMainCategoryUseCase)
      : super(BannersInitial()) {
    _getBanners();
    _getCategories();
  }

  List<BannersModel> banners = [];
  List<BannersModel> categories = [];

  Future<void> _getBanners() async {
    emit(GetBannersLoading());
    final response = await _getBannersUseCase();
    response.fold(
      (failure) => emit(GetBannersFailure(msg: failure.msg)),
      (success) {
        banners = success.data;
        emit(GetBannersSuccess(banners: success.data));
      },
    );
  }

  Future<void> _getCategories() async {
    emit(GetBannersLoading());
    final response = await getMainCategoryUseCase();
    response.fold(
      (failure) => emit(GetBannersFailure(msg: failure.msg)),
      (success) {
        categories = success.data;
        emit(GetBannersSuccess(banners: success.data));
      },
    );
  }
}
