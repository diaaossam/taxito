import 'package:aslol/features/order/data/models/product_params.dart';
import 'package:aslol/features/product/domain/usecases/get_products_use_case.dart';
import 'package:aslol/features/product/domain/usecases/get_suppliers_product_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product_model.dart';

part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase _getProductUseCase;
  final GetSuppliersProductUseCase getSuppliersProductUseCase;

  ProductCubit(this._getProductUseCase, this.getSuppliersProductUseCase)
      : super(ProductInitial());
  final PagingController<int, ProductModel> mostSellingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, ProductModel> bestOffersController =
      PagingController(firstPageKey: 1);
  final PagingController<int, ProductModel> recommendedController =
      PagingController(firstPageKey: 1);

  Future<List<ProductModel>> _getProducts({
    required ProductParams params,
  }) async {
    List<ProductModel> products = [];
    final data = params.supplierId == null
        ? await _getProductUseCase(params: params)
        : await getSuppliersProductUseCase(params: params);
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
      {required ProductParams params,
      required PagingController<int, ProductModel> pagingController,
      required int pageKey}) async {
    try {
      final newItems = await _getProducts(params: params);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey.toInt());
      }
      emit(GetProductSuccess());
    } catch (error) {
      pagingController.error = error;
    }
  }
}
