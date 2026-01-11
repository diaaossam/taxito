import 'package:equatable/equatable.dart';

class ProductParams extends Equatable {
  final num? pageKey;
  final num? isFeatured;
  final num? isRecommended;
  final num? isMostSelling;
  final num? supplierId;
  final num? productCategoryId;
  final String? search;
  final List<num>? productCategories;
  final List<num>? supplierCategories;
  final String? sortBy;

  const ProductParams({
    this.pageKey = 1,
    this.isFeatured,
    this.productCategoryId,
    this.isRecommended,
    this.supplierId,
    this.isMostSelling,
    this.search,
    this.productCategories,
    this.supplierCategories,
    this.sortBy,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'page': pageKey,
      'is_featured': isFeatured,
      'is_recommended': isRecommended,
      'is_most_selling': isMostSelling,
      'search': search,
      'product_categories': productCategories,
      'supplier_categories': supplierCategories,
      'sort_by': sortBy,
    };
    map.removeWhere(
          (key, value) => value == null,
    );
    return map;
  }

  ProductParams copyWith({
    int? pageKey,
    int? isFeatured,
    int? isRecommended,
    int? isMostSelling,
    String? search,
    List<num>? productCategories,
    List<num>? supplierCategories,
    num? supplierId,
    num? productCategoryId,
    String? sortBy,
    String? orderDirection,
    num? showAvailableFirst,
  }) {
    return ProductParams(
      pageKey: pageKey ?? this.pageKey,
      isFeatured: isFeatured ?? this.isFeatured,
      isRecommended: isRecommended ?? this.isRecommended,
      isMostSelling: isMostSelling ?? this.isMostSelling,
      search: search ?? this.search,
      productCategories: productCategories ?? this.productCategories,
      supplierCategories: supplierCategories ?? this.supplierCategories,
      productCategoryId: productCategoryId ?? this.productCategoryId,
      supplierId: supplierId ?? this.supplierId,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  List<Object?> get props => [
    pageKey,
    isFeatured,
    isRecommended,
    isMostSelling,
    search,
    productCategories,
    supplierCategories,
    supplierId,
    productCategoryId,
    sortBy,
  ];
}
