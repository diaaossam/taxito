import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../product/domain/usecases/submit_review_use_case.dart';

part 'rating_state.dart';

@Injectable()
class RatingCubit extends Cubit<RatingState> {
  final SubmitReviewUseCase submitReviewUseCase;

  RatingCubit(this.submitReviewUseCase) : super(RatingInitial());

  Future<void> submitRating({required Map<String, dynamic> map}) async {
    emit(SubmitRatingLoading());
    final response = await submitReviewUseCase(map: map);
    emit(response.fold((l) => SubmitRatingFailure(msg: l.msg),
        (r) => SubmitRatingSuccess(msg: r.data)));
  }
}
