import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/captain/delivery_order/presentation/cubit/statics/statics_cubit.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';

class StaticsInfoDesign extends StatelessWidget {
  const StaticsInfoDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StaticsCubit>(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: context.localizations.statics,
            fontWeight: FontWeight.bold,
            textSize: 15,
          ),
          10.verticalSpace,
          BlocBuilder<StaticsCubit, StaticsState>(
            builder: (context, state) {
              final bloc = context.read<StaticsCubit>();
              if (state is GetStaticsLoading) {
                return const LoadingWidget();
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildStaticsItem(
                        context: context,
                        title: context.localizations.totalOrders,
                        data: bloc.staticsModel!.total.toString(),
                        press: () {},
                        image: Assets.images.frame2147226944.path,
                        color: const Color(0xff2ABA66)),
                    _buildStaticsItem(
                        context: context,
                        title: context.localizations.delivered,
                        data: bloc.staticsModel!.completed.toString(),
                        press: () {},
                        image: Assets.images.frame2147226945.path,
                        color: const Color(0xff7A4F9C)),
                    _buildStaticsItem(
                        context: context,
                        title: context.localizations.profits,
                        data: "${formatPrice(price: bloc.staticsModel!.profits.toString())} ${context.localizations.iqd}",
                        press: () {},
                        image: Assets.images.a08PhotoroomPhotoroom2.path,
                        color: const Color(0xff00ABB9)),
                    _buildStaticsItem(
                        context: context,
                        title: context.localizations.rating,
                        data: bloc.staticsModel!.rating.toString(),
                        press: () {},
                        image: Assets.images.a08PhotoroomPhotoroom1.path,
                        color: const Color(0xffC76432)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStaticsItem(
      {required BuildContext context,
      required String title,
      required String image,
      required String data,
      required Color color,
      required VoidCallback press}) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsetsDirectional.only(end: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            AppText(
              text: title,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            8.verticalSpace,
            Row(
              children: [
                AppImage.asset(
                  image,
                  height: 30,
                  width: 30,
                ),
                10.horizontalSpace,
                AppText(
                  text: data,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  textSize: 17,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String formatPrice({
  required dynamic price,
  int decimalDigits = 0,
  String locale = 'en',
}) {
  final formatter = NumberFormat.decimalPattern(locale)
    ..minimumFractionDigits = decimalDigits
    ..maximumFractionDigits = decimalDigits;
  return formatter.format(num.tryParse(price));
}

