import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/features/user/trip/data/models/trip_model.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../domain/entities/review_trip_params.dart';
import '../bloc/trip_rating/trip_rating_bloc.dart';

class TripRatingDesign extends StatefulWidget {
  final TripModel tripModel;

  const TripRatingDesign({super.key, required this.tripModel});

  @override
  State<TripRatingDesign> createState() => _TripRatingDesignState();
}

class _TripRatingDesignState extends State<TripRatingDesign> {
  double rating = 5;
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    if (widget.tripModel.rate != null) {
      rating = widget.tripModel.rate!.rate!.toDouble();
      if (widget.tripModel.rate!.comment != null) {
        _ratingController.text = widget.tripModel.rate!.comment!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripRatingBloc>(),
      child: BlocConsumer<TripRatingBloc, TripRatingState>(
        listener: (context, state) {
          if (state is SendTripRatingFailure) {
            AppConstant.showCustomSnakeBar(context, state.message, false);
          }
          if (state is SendTripRatingSuccess) {
            AppConstant.showCustomSnakeBar(context, state.msg, true);
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.tripModel.rate == null) ...[
                AppText(
                  text: context.localizations.rateDriverBody,
                  fontWeight: FontWeight.w600,
                ),
                20.verticalSpace,
              ],

              Center(
                child: RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  ignoreGestures: widget.tripModel.rate != null,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 27,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (value) => setState(() => rating = value),
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomTextFormField(
                controller: _ratingController,
                maxLines: 6,
                readOnly: widget.tripModel.rate != null,
              ),
              if (widget.tripModel.rate == null) ...[
                SizedBox(height: SizeConfig.bodyHeight * .02),
                CustomButton(
                  isLoading: state is SendTripRatingLoading,
                  text: context.localizations.sendRating,
                  press: () {
                    BlocProvider.of<TripRatingBloc>(context).add(
                      SendTripRatingEvent(
                        tripParams: ReviewTripParams(
                          tripId: widget.tripModel.id!.toInt(),
                          review: _ratingController.text,
                          rating: rating,
                        ),
                      ),
                    );
                  },
                ),
              ],

              SizedBox(height: SizeConfig.bodyHeight * .02),
            ],
          );
        },
      ),
    );
  }
}
