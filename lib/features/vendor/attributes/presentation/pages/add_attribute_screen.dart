import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';

import '../../data/models/attribute_model.dart';
import '../cubit/attributes_cubit.dart';
import '../widgets/add_attribute/add_edit_attribute_form.dart';

class AddAttributeScreen extends StatelessWidget {
  final AttributeModel? attributeModel;

  const AddAttributeScreen({super.key, this.attributeModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AttributesCubit>(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: CustomAppBar(title: context.localizations.addNewAttribute),
        body: AddEditAttributeForm(model: attributeModel),
      ),
    );
  }
}
