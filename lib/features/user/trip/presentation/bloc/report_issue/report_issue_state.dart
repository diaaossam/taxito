part of 'report_issue_bloc.dart';

@immutable
sealed class ReportIssueState {}

final class ReportIssueInitial extends ReportIssueState {}
final class SendReportIssueLoading extends ReportIssueState {}
final class SendReportIssueSuccess extends ReportIssueState {
  final String msg;

  SendReportIssueSuccess({required this.msg});
}
final class SendReportIssueFailure extends ReportIssueState {
  final String msg
  ;

  SendReportIssueFailure({required this.msg});
}
