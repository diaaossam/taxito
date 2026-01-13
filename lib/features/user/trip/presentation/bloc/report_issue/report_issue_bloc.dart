import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/data/models/trip_model.dart';
import '../../../domain/usecases/report_trip_issue_use_case.dart';

part 'report_issue_event.dart';

part 'report_issue_state.dart';

@Injectable()
class ReportIssueBloc extends Bloc<ReportIssueEvent, ReportIssueState> {
  final ReportTripIssueUseCase reportTripIssueUseCase;

  ReportIssueBloc(this.reportTripIssueUseCase) : super(ReportIssueInitial()) {
    on<SendReportIssueEvent>((event, emit) async {
      emit(SendReportIssueLoading());
      final response = await reportTripIssueUseCase(
          tripModel: event.tripModel, msg: event.issue);
      emit(response.fold(
        (l) => SendReportIssueFailure(msg: l.msg),
        (r) => SendReportIssueSuccess(msg: r.message ?? ""),
      ));
    });
  }
}
