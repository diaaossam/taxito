import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/trip/trip_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/data/models/trip_model.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../bloc/report_issue/report_issue_bloc.dart';

class ReportTripScreen extends StatefulWidget {
  final TripModel tripModel;

  const ReportTripScreen({super.key, required this.tripModel});

  @override
  State<ReportTripScreen> createState() => _ReportTripScreenState();
}

class _ReportTripScreenState extends State<ReportTripScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReportIssueBloc>(),
      child: BlocConsumer<ReportIssueBloc, ReportIssueState>(
        listener: (context, state) {
          if (state is SendReportIssueFailure) {
            AppConstant.showCustomSnakeBar(context, state.msg, false);
          } else if (state is SendReportIssueSuccess) {
            TripHelper().showSuccessReport(
              context: context,
              model: widget.tripModel,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(title: context.localizations.reportOnIssue),
            body: Padding(
              padding: screenPadding(),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.bodyHeight * 0.04),
                  CustomTextFormField(
                    controller: textEditingController,
                    maxLines: 8,
                    hintText: context.localizations.enterYourProblem,
                  ),
                  const Spacer(),
                  CustomButton(
                    isLoading: state is SendReportIssueLoading,
                    text: context.localizations.send,
                    press: () {
                      if (textEditingController.text.isEmpty) {
                        AppConstant.showCustomSnakeBar(
                          context,
                          context.localizations.IssueMessageValidation,
                          false,
                        );
                        return;
                      }
                      context.read<ReportIssueBloc>().add(
                        SendReportIssueEvent(
                          tripModel: widget.tripModel,
                          issue: textEditingController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * 0.04),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
