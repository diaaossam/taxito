import 'package:flutter/material.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../captain/app/data/models/generic_model.dart';
import '../cubit/categories_cubit.dart';
import '../widgets/add_edit_category_body.dart';

class AddEditCategoryScreen extends StatelessWidget {
  final GenericModel? model;

  const AddEditCategoryScreen({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoriesCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: model == null
              ? context.localizations.addNewCategory
              : context.localizations.edit,
        ),
        body: AddEditCategoryBody(model: model),
      ),
    );
  }
}
