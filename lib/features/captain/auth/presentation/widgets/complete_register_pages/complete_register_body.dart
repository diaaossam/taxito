import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/auth/presentation/widgets/complete_register_pages/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import '../../cubit/complete_register/complete_register_bloc.dart';
import 'complete_register/complete_register_page1/complete_register_page_1.dart';
import 'complete_register/complete_register_page2/complete_register_page_2.dart';
import 'complete_register/complete_register_page3/complete_register_page_3.dart';

class DriverCompleteRegisterBody extends StatelessWidget {
  final bool isUpdate;
  const DriverCompleteRegisterBody({super.key, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteRegisterBloc, CompleteRegisterState>(
      builder: (context, state) {
        final bloc = context.read<CompleteRegisterBloc>();
        return Column(
          children: [
            SizedBox(height: SizeConfig.bodyHeight*.02,),
            StepperDesign(stepActive: bloc.currentStep),
            Expanded(
              child: LazyIndexedStack(
                index: bloc.currentStep,
                children: <Widget>[
                  CompleteRegisterPage1(isUpdate: isUpdate,),
                  CompleteRegisterPage2(isUpdate: isUpdate,),
                   CompleteRegisterPage3(isUpdate: isUpdate,),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
