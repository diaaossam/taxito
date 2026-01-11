import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/captain/app/data/models/generic_model.dart';
import 'package:taxito/features/captain/settings/domain/usecases/get_faq_use_case.dart';
import 'package:meta/meta.dart';

part 'faqs_question_state.dart';

@Injectable()
class FaqsQuestionCubit extends Cubit<FaqsQuestionState> {
  final GetAllFaqsUseCase getAllFaqsUseCase;

  FaqsQuestionCubit(this.getAllFaqsUseCase) : super(FaqsQuestionInitial());

  Future<void> getAllQuestion() async {
    emit(GetAllFaqsQuestionLoading());
    final response = await getAllFaqsUseCase();
    emit(response.fold((l) => GetAllFaqsQuestionFailure(),
        (r) => GetAllFaqsQuestionSuccess(list: r.data)));
  }
}
