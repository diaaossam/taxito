import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/page_controller_extention.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/auth/presentation/pages/login_screen.dart';
import 'package:taxito/features/common/start/presentation/cubit/boarding/on_boarding_cubit.dart';
import 'package:taxito/features/common/start/presentation/pages/welcome_screen.dart';
import 'package:taxito/features/common/start/presentation/widgets/on_boarding/progress_circulure.dart';
import 'package:taxito/widgets/app_failure.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../../gen/assets.gen.dart';
import 'boarding_content.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is StartAppState) {
          context.navigateTo(const WelcomeScreen());
        }
      },
      builder: (context, state) {
        OnBoardingCubit cubit = context.read<OnBoardingCubit>();
        if (state is GetIntroDataLoading) {
          return const LoadingWidget();
        } else if (state is GetIntroDataFailure) {
          return AppFailureWidget(
            image: Assets.images.noNetwork.path,
            buttonText: context.localizations.reload,
            title: context.localizations.noNetwork,
            body: context.localizations.noNetworkBody,
            padding: const EdgeInsets.all(40),
            height: SizeConfig.bodyHeight * .2,
            callback: () => cubit.getIntroData(),
          );
        }
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              onPageChanged: (index) {
                if (index == cubit.introList.length - 1) {
                  cubit.changePageViewState(true);
                } else {
                  cubit.changePageViewState(false);
                }
              },
              itemCount: cubit.introList.length,
              physics: const BouncingScrollPhysics(),
              controller: cubit.boardController,
              itemBuilder: (context, index) {
                final item = cubit.introList[index];
                return BoardingContent(
                  title: item.title,
                  image: item.image,
                  text: item.description,
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(bottom: SizeConfig.bodyHeight * .04),
              padding: screenPadding(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SmoothPageIndicator(
                    controller: cubit.boardController,
                    count: cubit.introList.length,
                    effect: ExpandingDotsEffect(
                      dotColor:
                          context.colorScheme.shadow.withValues(alpha: 0.2),
                      activeDotColor: context.colorScheme.primary,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const ProgressCirculureWidget(),
                      InkWell(
                        onTap: () {
                          if (cubit.isLast) {
                            cubit.submit();
                          } else {
                            cubit.boardController.toNextPage();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: AppImage.asset(
                            Assets.icons.arrowForward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /*InkWell(
                    onTap: () {
                      if (cubit.isLast) {
                        cubit.submit();
                      } else {
                        cubit.boardController.toNextPage();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          shape: BoxShape.circle),
                      child: AppImage.asset(
                        Assets.icons.arrowForward,
                        color: Colors.white,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
