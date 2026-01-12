import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:taxito/core/data/models/product_model.dart';
import '../../../../product/data/models/request/product_params.dart';
import '../../../../product/data/repositories/product_repository.dart';

part 'category_details_state.dart';

@Injectable()
class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final ProductRepository productRepository;

  CategoryDetailsCubit(this.productRepository)
    : super(CategoryDetailsInitial());

  final PagingController<int, ProductModel> pagingController = PagingController(
    firstPageKey: 1,
  );

  Future<List<ProductModel>> _getProducts({
    required ProductParams params,
  }) async {
    List<ProductModel> products = [];
    final data = await productRepository.getProducts(params: params);
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

  Future<void> fetchPage({
    required ProductParams params,
    required int pageKey,
  }) async {
    try {
      final newItems = await _getProducts(params: params);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey.toInt());
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
