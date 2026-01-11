import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../data/models/attribute_model.dart';
import '../../../data/models/sub_attribute_value_model.dart';
import '../../../domain/usecases/get_attributes_use_case.dart';
import '../../../domain/usecases/upload_sub_attribute_use_case.dart';

part 'sub_attributes_state.dart';

@Injectable()
class SubAttributesCubit extends Cubit<SubAttributesState> {
  final GetAttributesUseCase getAttributesUseCase;
  final UploadSubAttributeUseCase uploadSubAttributeUseCase;

  List<num> selectedAttributes = [];

  SubAttributesCubit(this.getAttributesUseCase, this.uploadSubAttributeUseCase)
    : super(AttributesInitial());
  final PagingController<int, AttributeModel> pagingController =
      PagingController(firstPageKey: 1);

  void setSelectedAttributes(List<num> attributes) {
    selectedAttributes = attributes;
    pagingController.refresh();
  }

  Future<List<AttributeModel>> fetchAttributes({required int pageKey}) async {
    List<AttributeModel> list = [];
    final response = await getAttributesUseCase(page: pageKey);
    response.fold(
      (l) {
        list = [];
      },
      (r) {
        list = r.data;
      },
    );

    // Filter attributes based on selected attributes
    if (selectedAttributes.isNotEmpty) {
      list = list
          .where((attribute) => selectedAttributes.contains(attribute.id))
          .toList();
    }

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

  Future<void> postSubAttributes({
    required Map<num, List<SubAttributeValueModel>> map,
  }) async {
    emit(AttributesActionLoading());
    final response = await uploadSubAttributeUseCase(map: map);
    emit(
      response.fold(
        (l) => AttributesActionFailure(msg: l.msg),
        (r) => AttributesActionSuccess(),
      ),
    );
  }
}
