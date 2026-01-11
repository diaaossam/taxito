part of 'filter_cubit.dart';

@immutable
sealed class FilterState {}

final class FilterInitial extends FilterState {}

final class FilterLoading extends FilterState {}

final class FilterFailure extends FilterState {
  final String msg;

  FilterFailure({required this.msg});
}

class FilterLoaded extends FilterState {
  final List<BannersModel> mainCategories;

  FilterLoaded({
    required this.mainCategories,
  });
}

final class UpdateFilterParamsState extends FilterState {}

final class ShowFilterDialog extends FilterState {
  final bool applySearch;

  ShowFilterDialog({required this.applySearch});
}
