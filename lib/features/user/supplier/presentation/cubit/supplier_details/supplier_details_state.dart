part of 'supplier_details_bloc.dart';

@immutable
sealed class SupplierDetailsState {}

final class SupplierDetailsInitial extends SupplierDetailsState {}
final class GetSupplierDetailsLoading extends SupplierDetailsState {}
final class GetSupplierDetailsSuccess extends SupplierDetailsState {}
final class GetSupplierDetailsFailure extends SupplierDetailsState {
  final String msg;

  GetSupplierDetailsFailure({required this.msg});
}
final class SelectCategoryState extends SupplierDetailsState {
  final GenericModel model;

  SelectCategoryState({required this.model});
}
