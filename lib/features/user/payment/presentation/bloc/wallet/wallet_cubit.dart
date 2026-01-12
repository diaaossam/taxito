import 'package:taxito/features/user/payment/data/models/transaction_model.dart';
import 'package:taxito/features/user/payment/domain/usecases/get_current_balance_use_case.dart';
import 'package:taxito/features/user/payment/domain/usecases/get_transaction_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'wallet_state.dart';

@Injectable()
class WalletCubit extends Cubit<WalletState> {
  final GetTransactionUseCase getTransactionUseCase;
  final GetCurrentBalanceUseCase getCurrentBalanceUseCase;

  WalletCubit(this.getTransactionUseCase, this.getCurrentBalanceUseCase)
      : super(WalletInitial());

  final PagingController<int, TransactionModel> pagingController =
      PagingController(firstPageKey: 0);

  void init() {
    getBalance();
    pagingController.addPageRequestListener(
      (pageKey) => fetchPage(pageKey: pageKey),
    );
  }

  Future<List<TransactionModel>> getHistoryTransactions(
      {required int pageKey}) async {
    List<TransactionModel> list = [];
    final response = await getTransactionUseCase(pageKey: pageKey);
    response.fold(
      (l) => list = [],
      (r) => list = r.data,
    );
    return list;
  }

  Future<void> fetchPage({required int pageKey}) async {
    try {
      final newItems = await getHistoryTransactions(pageKey: pageKey);
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

  num currentBalance = 0;

  Future<void> getBalance() async {
    emit(GetWalletBalanceLoading());
    final response = await getCurrentBalanceUseCase();
    emit(response.fold(
      (l) => GetWalletBalanceFailure(msg: l.msg),
      (r) {
        currentBalance = r.data;
        return GetWalletBalanceSuccess(balance: r.data);
      },
    ));
  }
}
