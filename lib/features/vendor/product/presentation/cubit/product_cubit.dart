import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/vendor/product/data/models/request/add_product_params.dart';
import 'package:taxito/features/vendor/product/data/repositories/product_repository.dart';

import '../../../order/data/models/response/product_model.dart';

part 'product_state.dart';

@Injectable()
class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(ProductInitial());

  Future<void> addProduct({required AddProductParams params}) async {
    emit(ProductActionLoading(isGetProduct: true));
    final response = await productRepository.addProduct(params: params);
    response.fold(
      (failure) => emit(ProductActionFailure(msg: failure.msg)),
      (success) => emit(ProductActionSuccess(msg: success.message ?? "")),
    );
  }

  Future<void> deleteProduct({required num id}) async {
    emit(ProductActionLoading(isGetProduct: false));
    final response = await productRepository.deleteProduct(id: id);
    response.fold(
      (failure) => emit(ProductActionFailure(msg: failure.msg)),
      (success) => emit(ProductActionSuccess(msg: success.message ?? "")),
    );
  }

  Future<void> getProduct({required num id, required bool isInit}) async {
    emit(ProductActionLoading(isGetProduct: false));
    final response = await productRepository.getProduct(id: id);
    response.fold(
      (failure) => emit(ProductActionFailure(msg: failure.msg)),
      (success) => emit(
        ProductActionSuccess(
          msg: "",
          productModel: success.data,
          isInit: isInit,
        ),
      ),
    );
  }
}
