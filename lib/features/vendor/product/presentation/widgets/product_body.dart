import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../categories/presentation/cubit/details/category_details_cubit.dart';
import '../../../categories/presentation/widgets/category_details/category_details_body.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({super.key});

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryDetailsCubit>(),
      child: const CategoryDetailsBody(),
    );
  }
}
