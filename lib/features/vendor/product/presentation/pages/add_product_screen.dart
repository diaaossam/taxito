import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../attributes/presentation/cubit/attributes_cubit.dart';
import '../../../categories/presentation/cubit/categories_cubit.dart';
import 'package:taxito/features/common/models/product_model.dart'
    show ProductModel;
import '../cubit/product_cubit.dart';
import '../widgets/add_product/add_product_body.dart';

class AddProductScreen extends StatelessWidget {
  final ProductModel? productModel;

  const AddProductScreen({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ProductCubit>()),
        BlocProvider(
          create: (context) =>
              sl<CategoriesCubit>()..fetchCategories(pageKey: 1),
        ),
        BlocProvider(
          create: (context) =>
              sl<AttributesCubit>()..fetchAttributes(pageKey: 1),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: productModel != null
              ? context.localizations.editProduct
              : context.localizations.addProduct,
        ),
        body: AddProductBody(productModel: productModel),
      ),
    );
  }
}
