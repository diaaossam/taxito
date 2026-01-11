part of 'report_issue_bloc.dart';

@immutable
sealed class ReportIssueEvent {}

class SendReportIssueEvent extends ReportIssueEvent {
  final TripModel tripModel;
  final String issue;

  SendReportIssueEvent({required this.tripModel, required this.issue});
}
