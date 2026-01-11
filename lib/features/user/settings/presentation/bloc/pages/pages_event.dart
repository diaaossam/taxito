part of 'pages_bloc.dart';

@immutable
sealed class PagesEvent {}
class GetPageDataEvent extends PagesEvent{
  final int pageNumber;

  GetPageDataEvent({required this.pageNumber});
}
