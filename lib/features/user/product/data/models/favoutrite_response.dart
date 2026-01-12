import 'package:taxito/core/data/models/product_model.dart';

import '../../../supplier/data/models/response/supplier_model.dart';

class FavouriteResponse {
  final ProductModel? productModel;
  final SupplierModel? supplierModel;
  final int type;

  FavouriteResponse({this.productModel, this.supplierModel, required this.type});
}
