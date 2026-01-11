import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/settings/presentation/bloc/pages/pages_bloc.dart';
import 'package:taxito/features/captain/settings/presentation/widgets/privacy_loading.dart';
import 'package:taxito/widgets/app_failure.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_sliver_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final int page;

  const PrivacyPolicyScreen({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<PagesBloc>()..add(GetPageDataEvent(pageNumber: page)),
      child: BlocBuilder<PagesBloc, PagesState>(
        builder: (context, state) {
          if (state is GetPageNumberLoading) {
            return const PrivacyPolicyShimmer();
          } else if (state is GetPageNumberFailure) {
            return const AppFailureWidget();
          } else if (state is GetPageNumberSuccess) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    title: state.genericModel.title,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: SizeConfig.bodyHeight*.02,),
                  ),
                  SliverPadding(
                    padding: screenPadding(),
                    sliver: SliverToBoxAdapter(
                      child: AppText(
                        text: state.genericModel.description ?? "",
                        fontWeight: FontWeight.w500,
                        textSize: 13,
                        color: context.colorScheme.shadow,
                        maxLines: 200,
                        textHeight: 1.7,
                      ),
                    ),
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
