import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../data/models/attribute_model.dart';
import '../../domain/usecases/add_attribute_use_case.dart';
import '../../domain/usecases/delete_attribute_use_case.dart';
import '../../domain/usecases/get_attributes_use_case.dart';
import '../../domain/usecases/update_attribute_use_case.dart';

part 'attributes_state.dart';

@Injectable()
class AttributesCubit extends Cubit<AttributesState> {
  final GetAttributesUseCase getAttributesUseCase;
  final AddAttributeUseCase addAttributeUseCase;
  final UpdateAttributeUseCase updateAttributeUseCase;
  final DeleteAttributeUseCase deleteAttributeUseCase;

  AttributesCubit(
    this.getAttributesUseCase,
    this.addAttributeUseCase,
    this.updateAttributeUseCase,
    this.deleteAttributeUseCase,
  ) : super(AttributesInitial());

  final PagingController<int, AttributeModel> pagingController =
      PagingController(firstPageKey: 1);

  List<AttributeModel> attributes = [];

  Future<List<AttributeModel>> fetchAttributes({required int pageKey}) async {
    emit(AttributesActionLoading());
    List<AttributeModel> list = [];
    final response = await getAttributesUseCase(page: pageKey);
    response.fold(
      (l) {
        list = [];
        emit(AttributesActionFailure(msg: l.msg));
      },
      (r) {
        list = r.data;
        attributes = list;
        emit(AttributesActionSuccess(response: r));
      },
    );
    return list;
  }

  Future<void> fetchPage(int page) async {
    try {
      final newItems = await fetchAttributes(pageKey: page);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> add({
    required String ar,
    required String en,
    required bool isRequired,
    required bool isMultiple,
    required bool isColor,
  }) async {
    emit(AttributesActionLoading());
    final body = {
      "title": {"ar": ar, "en": en},
      "is_required": isRequired,
      "is_multiple": isMultiple,
      "is_color": isColor,
    };
    final res = await addAttributeUseCase(body: body);
    emit(
      res.fold(
        (l) => AttributesActionFailure(msg: l.msg),
        (r) => AttributesActionSuccess(response: r),
      ),
    );
  }

  Future<void> update({
    required num id,
    required String ar,
    required String en,
    required bool isRequired,
    required bool isMultiple,
    required bool isColor,
  }) async {
    emit(AttributesActionLoading());
    final body = {
      "title": {"ar": ar, "en": en},
      "is_required": isRequired,
      "is_multiple": isMultiple,
      "is_color": isColor,
    };
    final res = await updateAttributeUseCase(id: id, body: body);
    emit(
      res.fold(
        (l) => AttributesActionFailure(msg: l.msg),
        (r) => AttributesActionSuccess(response: r),
      ),
    );
  }

  Future<void> remove({required num id}) async {
    emit(AttributesActionLoading());
    final res = await deleteAttributeUseCase(id: id);
    emit(
      res.fold(
        (l) => AttributesActionFailure(msg: l.msg),
        (r) => AttributesActionSuccess(response: r),
      ),
    );
  }
}
