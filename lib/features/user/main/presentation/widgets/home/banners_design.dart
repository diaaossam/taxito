import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/main/presentation/cubit/banner/banners_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';

class HomeBannersImage extends StatefulWidget {
  final double? height;

  const HomeBannersImage({super.key, this.height});

  @override
  State<HomeBannersImage> createState() => _HomeBannersImageState();
}

class _HomeBannersImageState extends State<HomeBannersImage> {
  int bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BannersCubit>(),
      child: BlocBuilder<BannersCubit, BannersState>(
        builder: (context, state) {
          if (state is GetBannersLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: SizeConfig.screenWidth,
                height: SizeConfig.bodyHeight * .25,
              ),
            );
          } else if (state is GetBannersSuccess) {
            final bloc = context.read<BannersCubit>();
            return Visibility(
              visible: bloc.banners.isNotEmpty,
              child: Column(
                children: [
                  CarouselSlider(
                    items: bloc.banners
                        .map((e) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: SizeConfig.screenWidth,
                              child: CachedNetworkImage(
                                imageUrl: e.image ?? "",
                                cacheKey: e.image ?? "",
                                width: SizeConfig.screenWidth,
                                fit: BoxFit.cover,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        onPageChanged: (index, reason) =>
                            setState(() => bannerIndex = index),
                        viewportFraction: 1,
                        height: widget.height ?? SizeConfig.bodyHeight * .25,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        scrollPhysics: const BouncingScrollPhysics()),
                  ),
                  SizedBox(
                    height: SizeConfig.bodyHeight * .01,
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: bannerIndex,
                    count: bloc.banners.length,
                    effect: WormEffect(
                      activeDotColor: context.colorScheme.primary,
                      dotColor: Colors.grey.shade300,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
