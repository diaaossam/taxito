class SuppliersParams {
  final int pageKey;
  final String? search;
  final List<num>? supplierCategories;

  SuppliersParams({
    this.search,
    this.supplierCategories,
    this.pageKey = 1,
  });

  SuppliersParams copyWith({
    int? pageKey,
    String? search,
    List<num>? supplierCategories,
  }) {
    return SuppliersParams(
      pageKey: pageKey ?? this.pageKey,
      search: search ?? this.search,
      supplierCategories: supplierCategories ?? this.supplierCategories,
    );
  }
}
