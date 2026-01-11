part of 'categories_cubit.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesActionLoading extends CategoriesState {}

class CategoriesActionSuccess extends CategoriesState {
  final ApiSuccessResponse response;
  CategoriesActionSuccess({required this.response});
}

class CategoriesActionFailure extends CategoriesState {
  final String msg;
  CategoriesActionFailure({required this.msg});
}














