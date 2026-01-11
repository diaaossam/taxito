import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/main/presentation/pages/main_layout.dart';
import 'package:aslol/features/trip/domain/entities/review_trip_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../data/models/trip_model.dart';
import '../../../trip_helper.dart';
import '../../bloc/trip_rating/trip_rating_bloc.dart';
import '../driver_info_widget.dart';

class RateDriverPage extends StatefulWidget {
  final TripModel tripModel;

  const RateDriverPage({super.key, required this.tripModel});

  @override
  State<RateDriverPage> createState() => _RateDriverPageState();
}

class _RateDriverPageState extends State<RateDriverPage> {
  final TextEditingController _ratingController = TextEditingController();
  double rating = 5;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripRatingBloc, TripRatingState>(
      listener: (context, state) {
        if (state is SendTripRatingFailure) {
          AppConstant.showCustomSnakeBar(context, state.message, false);
        } else if (state is SendTripRatingSuccess) {
          TripHelper().showSuccessRating(context: context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: screenPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                AppText(
                  text: context.localizations.completed1,
                  fontWeight: FontWeight.bold,
                  textSize: 16,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
                AppText(
                  text: context.localizations.rateTripBody,
                  fontWeight: FontWeight.w400,
                  textSize: 14,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                DriverInfoWidget(driver: widget.tripModel.driver!,trip: widget.tripModel,),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                Center(
                  child: RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 27,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) => setState(() => rating = value),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                CustomTextFormField(
                  controller: _ratingController,
                  hintText: context.localizations.rateDriverBody,
                  maxLines: 6,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                CustomButton(
                    isLoading: state is SendTripRatingLoading,
                    text: context.localizations.sendRating,
                    press: () {
                      BlocProvider.of<TripRatingBloc>(context).add(
                          SendTripRatingEvent(
                              tripParams: ReviewTripParams(
                                  tripId: widget.tripModel.id!.toInt(),
                                  review: _ratingController.text,
                                  rating: rating)));
                    }),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                CustomButton(
                    backgroundColor: Colors.transparent,
                    textColor: context.colorScheme.primary,
                    text: context.localizations.home,
                    press: () {
                      context.navigateToAndFinish(const MainLayout());
                    }),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
