import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../captain/app/data/models/generic_model.dart';
import '../../domain/usecases/add_category_use_case.dart';
import '../../domain/usecases/delete_category_use_case.dart';
import '../../domain/usecases/get_categories_use_case.dart';
import '../../domain/usecases/update_category_use_case.dart';

part 'categories_state.dart';

@Injectable()
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoriesCubit(
    this.getCategoriesUseCase,
    this.addCategoryUseCase,
    this.updateCategoryUseCase,
    this.deleteCategoryUseCase,
  ) : super(CategoriesInitial());

  final PagingController<int, GenericModel> pagingController = PagingController(
    firstPageKey: 1,
  );
  List<GenericModel> categories = [];

  Future<List<GenericModel>> fetchCategories({required int pageKey}) async {
    List<GenericModel> list = [];
    final response = await getCategoriesUseCase(page: pageKey);
    response.fold(
      (l) {
        list = [];
      },
      (r) {
        list = r.data;
        emit(CategoriesActionSuccess(response: r));
      },
    );
    categories = list;
    return list;
  }

  Future<void> fetchPage(int page) async {
    try {
      final newItems = await fetchCategories(
        pageKey: pagingController.nextPageKey ?? 1,
      );
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = (pagingController.nextPageKey ?? 1) + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> add({required String ar, required String en}) async {
    emit(CategoriesActionLoading());
    final body = {
      "title": {"ar": ar, "en": en},
    };
    final res = await addCategoryUseCase(body: body);
    emit(
      res.fold(
        (l) => CategoriesActionFailure(msg: l.msg),
        (r) => CategoriesActionSuccess(response: r),
      ),
    );
  }

  Future<void> update({
    required num id,
    required String ar,
    required String en,
  }) async {
    emit(CategoriesActionLoading());
    final body = {
      "title": {"ar": ar, "en": en},
    };
    final res = await updateCategoryUseCase(id: id, body: body);
    emit(
      res.fold(
        (l) => CategoriesActionFailure(msg: l.msg),
        (r) => CategoriesActionSuccess(response: r),
      ),
    );
  }

  Future<void> remove({required num id}) async {
    emit(CategoriesActionLoading());
    final res = await deleteCategoryUseCase(id: id);
    emit(
      res.fold(
        (l) => CategoriesActionFailure(msg: l.msg),
        (r) => CategoriesActionSuccess(response: r),
      ),
    );

    // Remove from paging controller
    final currentItems = pagingController.itemList ?? [];
    final updatedList = currentItems.where((item) => item.id != id).toList();
    pagingController.itemList = updatedList;
  }
}
