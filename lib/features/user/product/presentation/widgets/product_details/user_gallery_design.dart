import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/product/data/models/product_model.dart';
import 'package:taxito/features/user/product/presentation/widgets/image_view.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ProductGalleryDesign extends StatefulWidget {
  final List<Images> images;

  const ProductGalleryDesign({
    super.key,
    required this.images,
  });

  @override
  State<ProductGalleryDesign> createState() => _ProductGalleryDesignState();
}

class _ProductGalleryDesignState extends State<ProductGalleryDesign> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.images.isNotEmpty,
      child: CarouselSlider(
        items: widget.images
            .map((e) => InkWell(
                  onTap: () => context.navigateTo(
                      ImagePreviewScreen(
                        image: widget.images.map((e) => e.url ?? "").toList(),
                        url: e.url ?? "",
                      ),
                      pageTransitionType: PageTransitionType.bottomToTop,
                      duration: const Duration(milliseconds: 300)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AppImage.network(
                      remoteImage: e.url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
            onPageChanged: (index, reason) =>
                setState(() => imageIndex = index),
            viewportFraction: 1.0,
            height: SizeConfig.bodyHeight * .3,
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
    );
  }
}
