import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:taxito/features/vendor/product/data/models/response/review_model.dart';
import 'package:taxito/features/vendor/product/data/repositories/product_repository.dart';

part 'rating_state.dart';

@Injectable()
class RatingCubit extends Cubit<RatingState> {
  final ProductRepository productRepository;

  RatingCubit(this.productRepository) : super(RatingInitial());

  List<ReviewModel> reviews = [];

  Future<void> getProductReview({required num id}) async {
    emit(GetProductReviewLoading());
    final response = await productRepository.getReview(id: id);
    emit(
      response.fold((l) => GetProductReviewFailure(msg: l.msg), (r) {
        reviews = r.data;
        return GetProductReviewSuccess();
      }),
    );
  }
}
