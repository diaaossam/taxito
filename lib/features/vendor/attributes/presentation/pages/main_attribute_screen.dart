import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import '../../../main/presentation/cubit/delivery_main/delivery_main_cubit.dart';
import '../cubit/attributes_cubit.dart';
import '../widgets/main_attribute/main_attribute_body.dart';

class MainAttributeScreen extends StatelessWidget {
  const MainAttributeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<DeliveryMainCubit>().changeBottomNavIndex(index: 0);
      },
      child: BlocProvider(
        create: (context) => sl<AttributesCubit>(),
        child: Scaffold(
          appBar: CustomAppBar(title: context.localizations.attributes,showBackButton: false,),
          body: const MainAttributeBody(),
        ),
      ),
    );
  }
}
