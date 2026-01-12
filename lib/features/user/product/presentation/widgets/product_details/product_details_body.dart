import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_details/cart_button_design.dart';
import 'package:flutter/material.dart';
import 'package:taxito/core/data/models/product_model.dart';
import '../type_note_widget.dart';
import 'product_info_card.dart';
import 'attributes_design.dart';
import 'user_gallery_design.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailsBody({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding(),
        child: Column(
          children: [
            ProductGalleryDesign(
              images: productModel.images ?? [],
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .01,
            ),
            ProductInfoCard(
              productModel: productModel,
            ),
            AttributesDesign(
              attributes: productModel.attributes??[],
            ),
             const TypeNoteWidget(),
            SizedBox(height: SizeConfig.bodyHeight*.04,),
          ],
        ).scrollable(),
      ),
      bottomNavigationBar: CartButtonDesign(productModel: productModel,),
    );
  }
}
