import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/config/dependencies/injectable_dependencies.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/settings/presentation/bloc/faqs/faqs_question_cubit.dart';
import 'package:aslol/features/settings/presentation/widgets/privacy_loading.dart';
import 'package:aslol/features/settings/presentation/widgets/question/custom_expanded_widget.dart';
import 'package:aslol/widgets/app_failure.dart';
import 'package:aslol/widgets/custom_sliver_app_bar.dart';

class FaqQuestionScreen extends StatefulWidget {
  const FaqQuestionScreen({super.key});

  @override
  State<FaqQuestionScreen> createState() => _FaqQuestionScreenState();
}

class _FaqQuestionScreenState extends State<FaqQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FaqsQuestionCubit>()..getAllQuestion(),
      child: BlocBuilder<FaqsQuestionCubit, FaqsQuestionState>(
        builder: (context, state) {
          if (state is GetAllFaqsQuestionLoading) {
            return const PrivacyPolicyShimmer();
          } else if (state is GetAllFaqsQuestionFailure) {
            return const AppFailureWidget();
          } else if (state is GetAllFaqsQuestionSuccess) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    title: context.localizations.faq,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                  ),
                  SliverPadding(
                    padding: screenPadding(),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: state.list.length,
                            (context, index) => CustomExpandedWidget(
                                  title: state.list[index].title ?? '',
                                  body: state.list[index].title ?? "",
                                ))),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold();
          }
        },
      ),
    );
  }
}
