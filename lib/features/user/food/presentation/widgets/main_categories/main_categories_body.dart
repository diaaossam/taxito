import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/main/presentation/cubit/banner/banners_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_category_item.dart';

class MainCategoriesBody extends StatelessWidget {
  const MainCategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        final bloc = context.read<BannersCubit>();
        return Padding(
          padding: screenPadding(),
          child: GridView.custom(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 10),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: bloc.categories.length,
                (context, index) {
                  return MainCategoryItem(
                    isHome: false,
                    bannersModel: bloc.categories[index],
                  );
                },
              )),
        );
      },
    );
  }
}
