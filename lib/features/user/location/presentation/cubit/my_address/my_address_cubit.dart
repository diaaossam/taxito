import 'package:taxito/features/user/location/domain/usecases/delete_address_use_case.dart';
import 'package:taxito/features/user/location/domain/usecases/get_address_use_case.dart';
import 'package:taxito/features/user/order/domain/usecases/get_delivery_cost_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../captain/delivery_order/data/models/response/my_address.dart';
import '../../../domain/usecases/make_address_default_use_case.dart';

part 'my_address_state.dart';

@Injectable()
class MyAddressCubit extends Cubit<MyAddressState> {
  final GetAddressUseCase getAddressUseCase;
  final MakeAddressDefaultUseCase makeAddressDefaultUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final GetDeliveryCostUseCase getDeliveryCostUseCase;

  MyAddressCubit(
    this.getAddressUseCase,
    this.makeAddressDefaultUseCase,
    this.deleteAddressUseCase,
    this.getDeliveryCostUseCase,
  ) : super(MyAddressInitial()) {
    getMyAddress();
  }

  List<MyAddress> addressList = [];

  Future<void> getMyAddress() async {
    emit(GetMyAddressLoading());
    final response = await getAddressUseCase();
    emit(
      response.fold((l) => GetMyAddressFailure(msg: l.msg), (r) {
        addressList = r.data;
        return GetMyAddressSuccess();
      }),
    );
  }

  Future<void> makeAddressDefault({required MyAddress myAddress}) async {
    emit(MakeAddressDefaultLoading());
    final response = await makeAddressDefaultUseCase(myAddress: myAddress);
    emit(
      response.fold(
        (l) => MakeAddressDefaultFailure(msg: l.msg),
        (r) => MakeAddressDefaultSuccess(
          msg: r.message ?? "",
          myAddress: myAddress,
        ),
      ),
    );
  }

  Future<void> deleteAddress({required num id}) async {
    emit(DeleteAddressLoading());
    final response = await deleteAddressUseCase(id: id);
    emit(
      response.fold((l) => DeleteAddressFailure(msg: l.msg), (r) {
        addressList.removeWhere((element) => element.id == id);
        return DeleteAddressSuccess(msg: r.message ?? "");
      }),
    );
  }

  Future<void> getLocationCost({required num supplierId}) async {
    emit(GetLocationCostLoading());
    final response = await getDeliveryCostUseCase(supplierId: supplierId);
    emit(
      response.fold(
        (l) => GetLocationCostFailure(msg: l.msg),
        (r) => GetLocationCostSuccess(cost: r.data),
      ),
    );
  }
}
