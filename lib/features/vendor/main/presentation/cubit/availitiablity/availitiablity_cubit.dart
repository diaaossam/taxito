import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/toggle_availability_use_case.dart';
part 'availitiablity_state.dart';

@Injectable()
class AvailitiablityCubit extends Cubit<AvailitiablityState> {

  final ToggleAvailabilityUseCase toggleAvailabilityUseCase;

  AvailitiablityCubit(this.toggleAvailabilityUseCase)
      : super(AvailitiablityInitial());

  Future<void> toggleDriverAvailibtiy() async {
    emit(ChangeAvailitiablityLoading());
    final response = await toggleAvailabilityUseCase();
    emit(response.fold(
      (l) => ChangeAvailitiablityFailure(),
      (r) => ChangeAvailitiablitySuccess(),
    ));
  }
}
