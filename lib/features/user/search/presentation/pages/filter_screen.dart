import 'package:aslol/features/search/presentation/widgets/filter_body.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';
import '../cubit/filter/filter_cubit.dart';

class FilterScreen extends StatelessWidget {
  final bool isProduct;

  const FilterScreen({super.key, this.isProduct = true});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FilterCubit>(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: FilterBody(
          isProduct: isProduct,
        ),
      ),
    );
  }
}
