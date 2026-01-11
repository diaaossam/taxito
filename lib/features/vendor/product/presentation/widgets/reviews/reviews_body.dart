import 'package:flutter/material.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/features/vendor/product/presentation/widgets/reviews/review_item_widget.dart';

import '../../cubit/review/rating_cubit.dart';

class ReviewsBody extends StatelessWidget {
  const ReviewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingCubit, RatingState>(
      builder: (context, state) {
        final bloc = context.read<RatingCubit>();
        return Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(SizeConfig.screenWidth * .04),
                    itemCount: bloc.reviews.length,
                    itemBuilder: (context, index) {
                      return ReviewItemWidget(review: bloc.reviews[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
