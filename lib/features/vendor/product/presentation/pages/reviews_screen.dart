import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import 'package:taxito/features/common/models/product_model.dart';
import '../cubit/review/rating_cubit.dart';
import '../widgets/reviews/reviews_body.dart';

class ReviewsScreen extends StatelessWidget {
  final ProductModel productModel;

  const ReviewsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<RatingCubit>()..getProductReview(id: productModel.id!),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.localizations.rating,
          showBackButton: true,
        ),
        body: const ReviewsBody(),
      ),
    );
  }
}
