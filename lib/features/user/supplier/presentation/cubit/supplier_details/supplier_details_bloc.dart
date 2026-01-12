import 'package:taxito/core/data/models/product_model.dart';
import 'package:taxito/features/user/supplier/data/models/response/supplier_model.dart';
import 'package:taxito/features/user/supplier/domain/usecases/get_supplier_details_category_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../captain/app/data/models/generic_model.dart';

part 'supplier_details_event.dart';

part 'supplier_details_state.dart';

@Injectable()
class SupplierDetailsBloc
    extends Bloc<SupplierDetailsEvent, SupplierDetailsState> {
  final GetSupplierDetailsCategoryUseCase getSupplierCategoryUseCase;

  final PagingController<int, ProductModel> pagingController = PagingController(
    firstPageKey: 1,
  );

  List<GenericModel> categories = [];
  GenericModel? model;

  SupplierDetailsBloc(this.getSupplierCategoryUseCase)
    : super(SupplierDetailsInitial()) {
    on<GetSupplierDetailsEvent>((event, emit) async {
      emit(GetSupplierDetailsLoading());
      final response = await getSupplierCategoryUseCase(
        id: event.supplierModel.id ?? 0,
      );
      emit(
        response.fold((l) => GetSupplierDetailsFailure(msg: l.msg), (r) {
          categories = r.data;
          if (categories.isNotEmpty) {
            model = categories.first;
          }
          return GetSupplierDetailsSuccess();
        }),
      );
    });
    on<SelectCategoryEvent>((event, emit) {
      model = event.genericModel;
      emit(SelectCategoryState(model: event.genericModel));
    });
  }
}
