import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/complete_register/complete_register_bloc.dart';

class StepperDesign extends StatelessWidget {
  final int stepActive;

  const StepperDesign({
    super.key,
    required this.stepActive,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteRegisterBloc, CompleteRegisterState>(
      builder: (context, state) {
        final bloc = context.read<CompleteRegisterBloc>();
        final activeStep = bloc.currentStep;
        return EasyStepper(
          activeStep: bloc.currentStep,
          stepShape: StepShape.circle,
          showLoadingAnimation: false,
          padding: EdgeInsets.zero,
          disableScroll: true,
          stepRadius: 20,
          borderThickness: 0,
          lineStyle: LineStyle(
              lineSpace: 50,
              lineLength: 60,
              activeLineColor: context.colorScheme.primary,
              unreachedLineColor:
                  context.colorScheme.shadow.withValues(alpha: 0.2),
              lineThickness: 3,
              lineType: LineType.normal),
          enableStepTapping: false,
          steps: [
            EasyStep(
              customStep: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeStep >= 0
                        ? context.colorScheme.primary
                        : context.colorScheme.shadow),
                child: const Text(
                  "1",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customTitle: AppText(
                text: context.localizations.personalInfo,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.primary,
              ),
            ),
            EasyStep(
              customStep: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeStep >= 1
                        ? context.colorScheme.primary
                        : context.colorScheme.shadow),
                child: const Text(
                  "2",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customTitle: AppText(
                text: "      ${context.localizations.licenseData}",
                fontWeight: FontWeight.w600,
                color: activeStep >= 1
                    ? context.colorScheme.primary
                    : context.colorScheme.shadow,
              ),
            ),
            EasyStep(
              customStep: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeStep >= 2
                        ? context.colorScheme.primary
                        : context.colorScheme.shadow),
                child: const Text(
                  "3",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customTitle: AppText(
                text: context.localizations.vehicleInfo,
                fontWeight: FontWeight.w600,
                color: activeStep >= 1
                    ? context.colorScheme.primary
                    : context.colorScheme.shadow,
              ),
            ),
          ],
          onStepReached: (index) {},
        );
      },
    );
  }
}
