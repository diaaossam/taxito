import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductListLoading extends StatelessWidget {
  final double? imageHeight, imageWidth;
  final bool isScrollable;

  const ProductListLoading({
    super.key,
    this.imageHeight,
    this.imageWidth,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    if(isScrollable){
      return SizedBox(
        height: SizeConfig.bodyHeight * .25,
        child: ListView(
          children: const [
            ProductCardLoading(),
            ProductCardLoading(),
            ProductCardLoading(),
          ],
        ),
      );
    }else{
      return SizedBox(
        height: SizeConfig.bodyHeight * .25,
        child: const Row(
          children: [
            ProductCardLoading(),
            ProductCardLoading(),
            ProductCardLoading(),
          ],
        ),
      );
    }

  }
}

class ProductCardLoading extends StatelessWidget {
  final double? imageHeight, imageWidth;

  const ProductCardLoading({
    super.key,
    this.imageHeight,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: SizeConfig.screenWidth * .35,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: imageHeight ?? SizeConfig.bodyHeight * .18,
              width: imageWidth ?? SizeConfig.screenWidth * .38,
              decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                    16,
                  )),
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 14,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 8,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 8,
                width: SizeConfig.screenWidth * .12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
