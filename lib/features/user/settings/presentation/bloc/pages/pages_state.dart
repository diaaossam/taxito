part of 'pages_bloc.dart';

@immutable
sealed class PagesState {}

final class PagesInitial extends PagesState {}

final class GetPageNumberLoading extends PagesState {}

final class GetPageNumberSuccess extends PagesState {
  final GenericModel genericModel;

  GetPageNumberSuccess(this.genericModel);
}

final class GetPageNumberFailure extends PagesState {
  final String errorMsg;

  GetPageNumberFailure({required this.errorMsg});
}
