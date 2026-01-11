part of 'attributes_cubit.dart';

abstract class AttributesState {}

class AttributesInitial extends AttributesState {}

class AttributesActionLoading extends AttributesState {}

class AttributesActionSuccess extends AttributesState {
  final ApiSuccessResponse response;
  AttributesActionSuccess({required this.response});
}

class AttributesActionFailure extends AttributesState {
  final String msg;
  AttributesActionFailure({required this.msg});
}
