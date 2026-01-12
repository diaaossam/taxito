import 'package:taxito/features/user/supplier/data/models/requests/suppliers_params.dart';
import 'package:taxito/features/user/supplier/data/models/response/supplier_model.dart';
import 'package:taxito/features/user/supplier/domain/usecases/get_supplier_category_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'supplier_state.dart';

@Injectable()
class SupplierCubit extends Cubit<SupplierState> {
  final GetSupplierCategoryUseCase getSupplierCategoryUseCase;

  SupplierCubit(this.getSupplierCategoryUseCase) : super(SupplierInitial());

  final PagingController<int, SupplierModel> pagingController =
      PagingController(firstPageKey: 1);

  Future<List<SupplierModel>> _getSuppliers({
    required SuppliersParams params,
  }) async {
    List<SupplierModel> suppliers = [];
    final data = await getSupplierCategoryUseCase(params: params);
    data.fold(
      (l) {
        suppliers = [];
      },
      (r) {
        suppliers = r.data;
      },
    );
    return suppliers;
  }

  Future<void> fetchPage({
    required SuppliersParams params,
  }) async {
    try {
      final newItems = await _getSuppliers(params: params);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = params.pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey.toInt());
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
