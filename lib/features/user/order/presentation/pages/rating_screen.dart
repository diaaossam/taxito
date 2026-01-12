import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/features/user/order/data/models/orders.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../main/presentation/pages/main_layout.dart';
import '../bloc/rating/rating_cubit.dart';
import '../widgets/order_details/order_details_product.dart';
import '../widgets/track_order/delivery_rating_widget.dart';
import '../widgets/track_order/seller_rating_widget.dart';

class RatingScreen extends StatefulWidget {
  final Orders orders;
  final String type;
  final String title;

  const RatingScreen({
    super.key,
    required this.orders,
    required this.type,
    required this.title,
  });

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> map = {};
  num _rating = 5;

  @override
  void initState() {
    _initRating();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RatingCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(title: widget.title),
        body: Padding(
          padding: screenPadding(),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                if (widget.type == "supplier")
                  SellerRatingWidget(
                    ratingResponse: (p0) => setState(() => map = p0),
                    orders: widget.orders,
                  )
                else if (widget.type == "product")
                  OrderDetailsProduct(
                    ratingResponse: (p0) {
                      setState(() => map = p0);
                    },
                    orders: widget.orders,
                  )
                else
                  DeliveryRatingWidget(
                    ratingResponse: (p0) => setState(() => map = p0),
                    orders: widget.orders,
                  ),
                SizedBox(height: SizeConfig.bodyHeight * .06),
                BlocConsumer<RatingCubit, RatingState>(
                  listener: (context, state) {
                    if (state is SubmitRatingFailure) {
                      AppConstant.showCustomSnakeBar(context, state.msg, false);
                    }
                    if (state is SubmitRatingSuccess) {
                      context.navigateToAndFinish(const MainLayout());
                      AppConstant.showCustomSnakeBar(context, state.msg, true);
                    }
                  },
                  builder: (context, state) {
                    final bloc = context.read<RatingCubit>();
                    return CustomButton(
                      isLoading: state is SubmitRatingLoading,
                      text: context.localizations.send,
                      press: () {
                        bloc.submitRating(map: map);
                      },
                      height: 45.h,
                    );
                  },
                ),
              ],
            ).scrollable(),
          ),
        ),
      ),
    );
  }

  void _initRating() {
    if (widget.type == "product") {
      map['data'] = widget.orders.items!.map((element) {
        return {
          "product_id": element.product?.id,
          "rating": "5",
          "comment": "",
        };
      }).toList();
      map['rate_type'] = "product";
      map['id'] = widget.orders.id;
    }
    if (widget.type == "supplier") {
      map["rate_type"] = widget.type;
      map["rating"] = _rating.toString();
      map["id"] = widget.orders.id;
    } else {
      map["rate_type"] = "delivery";
      map["rating"] = _rating.toString();
      map["id"] = widget.orders.id;
    }
  }
}
