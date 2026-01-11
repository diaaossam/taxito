part of 'sub_attributes_cubit.dart';

abstract class SubAttributesState {}

class AttributesInitial extends SubAttributesState {}

class AttributesActionLoading extends SubAttributesState {}

class AttributesActionSuccess extends SubAttributesState {}

class AttributesActionFailure extends SubAttributesState {
  final String msg;

  AttributesActionFailure({required this.msg});
}
