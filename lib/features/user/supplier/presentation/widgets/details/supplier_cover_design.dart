import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/supplier/data/models/response/supplier_model.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';

class SupplierCoverDesign extends StatelessWidget {
  final SupplierModel supplierModel;
  const SupplierCoverDesign({super.key, required this.supplierModel});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: AppImage.network(
        height: SizeConfig.bodyHeight*.34,
        width: double.infinity,
        fit: BoxFit.cover,
        remoteImage: supplierModel.coverImage,
      ),
    );
  }
}
