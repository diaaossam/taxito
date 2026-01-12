import 'package:taxito/features/user/main/data/models/banners_model.dart';
import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:taxito/features/user/supplier/presentation/cubit/supplier_cubit.dart';
import 'package:taxito/features/user/supplier/presentation/widgets/suppliers_body.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';

class AllSuppliersScreen extends StatelessWidget {
  final BannersModel model;

  const AllSuppliersScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SupplierCubit>()),
        BlocProvider(create: (context) => sl<FavouriteCubit>()),
      ],
      child: Scaffold(
        appBar: CustomAppBar(title: model.title),
        body: SuppliersBody(bannersModel: model),
      ),
    );
  }
}
