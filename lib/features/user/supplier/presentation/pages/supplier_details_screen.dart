import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:taxito/features/user/supplier/data/models/response/supplier_model.dart';
import 'package:taxito/features/user/supplier/presentation/cubit/supplier_details/supplier_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../widgets/details/supplier_details_body.dart';

class SupplierDetailsScreen extends StatelessWidget {
  final SupplierModel supplierModel;

  const SupplierDetailsScreen({super.key, required this.supplierModel});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SupplierDetailsBloc>()
            ..add(GetSupplierDetailsEvent(supplierModel: supplierModel)),
        ),
        BlocProvider(
          create: (context) => sl<FavouriteCubit>(),
        ),
      ],
      child: Scaffold(
        body: SupplierDetailsBody(
          supplierModel: supplierModel,
        ),
      ),
    );
  }
}
