import 'package:aslol/features/product/domain/usecases/get_favourite_use_case.dart';
import 'package:aslol/features/product/domain/usecases/toggle_wishlist_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/favoutrite_response.dart';

part 'favourite_state.dart';

@Injectable()
class FavouriteCubit extends Cubit<FavouriteState> {
  final GetFavouriteUseCase getFavouriteUseCase;
  final ToggleWishlistUseCase toggleWishlistUseCase;

  FavouriteCubit(this.getFavouriteUseCase, this.toggleWishlistUseCase)
      : super(FavouriteInitial());

  Future<void> toggleWishlist({required num id, required String type}) async {
    emit(ToggleFavouriteLoading());
    final response = await toggleWishlistUseCase(id: id, type: type);
    emit(response.fold((l) => ToggleFavouriteFailure(msg: l.msg), (r) {
      /* pagingController.itemList?.removeWhere(
        (element) => element.id == id,
      );*/
      return ToggleFavouriteSuccess(msg: r.message ?? "");
    }));
  }

  Future<List<FavouriteResponse>> _getFavorite(
      {required int pageKey, required int type}) async {
    List<FavouriteResponse> products = [];
    final data = await getFavouriteUseCase(pageKey: pageKey, type: type);
    data.fold(
      (l) {
        products = [];
      },
      (r) {
        products = r.data;
      },
    );
    return products;
  }

  Future<void> fetchPage(
      {required int pageKey,
      required int type,
      required PagingController<int, FavouriteResponse>
          pagingController}) async {
    try {
      final newItems = await _getFavorite(pageKey: pageKey, type: type);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
