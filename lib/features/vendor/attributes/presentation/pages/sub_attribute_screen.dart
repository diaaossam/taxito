import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/data/models/product_model.dart';
import '../../../product/data/models/request/add_product_params.dart';
import '../../../product/presentation/cubit/product_cubit.dart';
import '../cubit/sub_attribute/sub_attributes_cubit.dart';
import '../widgets/sub_attribute/sub_attribute_body.dart';

class SubAttributeScreen extends StatelessWidget {
  final List<num> selectedAttributes;
  final AddProductParams params;
  final ProductModel? productModel;

  const SubAttributeScreen({
    super.key,
    required this.selectedAttributes,
    required this.params,
    this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = sl<SubAttributesCubit>();
            cubit.setSelectedAttributes(selectedAttributes);
            return cubit;
          },
        ),
        BlocProvider(create: (context) => sl<ProductCubit>()),
      ],
      child: Scaffold(
        appBar: CustomAppBar(title: context.localizations.subAttribute),
        body: SubAttributeBody(
          selectedAttributes: selectedAttributes,
          params: params,
          productModel: productModel,
        ),
      ),
    );
  }
}
