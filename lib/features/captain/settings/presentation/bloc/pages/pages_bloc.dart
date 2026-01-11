import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/captain/app/data/models/generic_model.dart';
import 'package:taxito/features/captain/settings/domain/usecases/get_page_use_case.dart';
import 'package:meta/meta.dart';

part 'pages_event.dart';

part 'pages_state.dart';

@Injectable()
class PagesBloc extends Bloc<PagesEvent, PagesState> {
  final GetPageUseCase getPageUseCase;

  PagesBloc(this.getPageUseCase) : super(PagesInitial()) {
    on<GetPageDataEvent>(
      (event, emit) async {
        emit(GetPageNumberLoading());
        final response = await getPageUseCase(pageNumber: event.pageNumber);
        emit(response.fold((l) => GetPageNumberFailure(errorMsg: l.msg),
            (r) => GetPageNumberSuccess(r.data)));
      },
    );
  }
}
