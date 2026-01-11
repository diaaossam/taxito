part of 'supplier_details_bloc.dart';

@immutable
sealed class SupplierDetailsEvent {}
class GetSupplierDetailsEvent extends SupplierDetailsEvent{
  final SupplierModel supplierModel;

  GetSupplierDetailsEvent({required this.supplierModel});
}
class SelectCategoryEvent extends SupplierDetailsEvent{
  final GenericModel genericModel;

  SelectCategoryEvent({required this.genericModel});
}
