import 'package:taxito/features/user/food/presentation/widgets/main_categories/main_category_filter_design.dart';
import 'package:taxito/features/user/search/presentation/cubit/filter/filter_cubit.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFilterGridDesign extends StatelessWidget {
  const CategoryFilterGridDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        final bloc = context.read<FilterCubit>();
        if (state is FilterLoading) return LoadingWidget();
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: bloc.mainCategories.map((category) {
            bool isSelected =
                bloc.params.productCategories?.contains(category.id) ?? false;
            return GestureDetector(
              onTap: () {
                if ((bloc.params.productCategories ?? [])
                    .contains(category.id)) {
                  bloc.params.productCategories?.remove(category.id);
                } else {
                  bloc.params = bloc.params.copyWith(productCategories: [
                    ...(bloc.params.productCategories ?? []),
                    category.id!
                  ]);
                }
                bloc.updateFilterParams(updatedParams: bloc.params);
              },
              child: MainCategoryFilterItem(
                isSelected: isSelected,
                bannersModel: category,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
