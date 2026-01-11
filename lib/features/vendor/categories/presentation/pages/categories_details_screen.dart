import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../captain/app/data/models/generic_model.dart';
import '../cubit/details/category_details_cubit.dart';
import '../widgets/category_details/category_details_body.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final GenericModel genericModel;

  const CategoriesDetailsScreen({super.key, required this.genericModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryDetailsCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(title: genericModel.title),
        body: CategoryDetailsBody(genericModel: genericModel),
      ),
    );
  }
}
