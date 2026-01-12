import 'package:taxito/features/user/payment/domain/usecases/add_balance_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'balance_state.dart';

@Injectable()
class BalanceCubit extends Cubit<BalanceState> {
  final AddBalanceUseCase addBalanceUseCase;

  BalanceCubit(this.addBalanceUseCase) : super(BalanceInitial());

  Future<void> addBalance({required num balance}) async {
    emit(AddBalanceLoading());
    final response = await addBalanceUseCase(data: balance);
    emit(response.fold(
      (l) => AddBalanceFailure(msg: l.msg),
      (r) => AddBalanceSuccess(),
    ));
  }
}
