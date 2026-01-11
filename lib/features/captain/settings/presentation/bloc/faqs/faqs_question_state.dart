part of 'faqs_question_cubit.dart';

@immutable
sealed class FaqsQuestionState {}

final class FaqsQuestionInitial extends FaqsQuestionState {}

final class GetAllFaqsQuestionLoading extends FaqsQuestionState {}

final class GetAllFaqsQuestionSuccess extends FaqsQuestionState {
  final List<GenericModel> list;

  GetAllFaqsQuestionSuccess({required this.list});
}

final class GetAllFaqsQuestionFailure extends FaqsQuestionState {}
