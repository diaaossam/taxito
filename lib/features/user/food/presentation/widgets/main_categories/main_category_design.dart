import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/main/presentation/cubit/banner/banners_cubit.dart';
import 'package:taxito/features/user/main/presentation/cubit/main/main_cubit.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main/presentation/pages/main_catrgories_screen.dart';
import 'home_main_category_loading.dart';
import 'main_category_item.dart';

class MainCategoryDesign extends StatefulWidget {
  final double? height;

  const MainCategoryDesign({super.key, this.height});

  @override
  State<MainCategoryDesign> createState() => _MainCategoryDesignState();
}

class _MainCategoryDesignState extends State<MainCategoryDesign> {
  int bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BannersCubit>(),
      child: BlocBuilder<BannersCubit, BannersState>(
        builder: (context, state) {
          final bloc = context.read<BannersCubit>();
          if (state is GetBannersLoading) {
            return const CategoriesShimmer();
          }
          else if (state is GetBannersSuccess) {
            return Column(
              children: [
                InkWell(
                  onTap: () =>context.navigateTo(const MainCatergoriesScreen()),
                  child: Padding(
                    padding: screenPadding(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: context.localizations.categories,
                          textSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        AppText(
                          text: context.localizations.showMore,
                          textSize: 11,
                          color: context.colorScheme.tertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                Container(
                  padding: screenPadding(),
                  child: GridView.custom(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 10),
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: bloc.categories.length < 8
                            ? bloc.categories.length
                            : 8,
                            (context, index) {
                          final category = bloc.categories[index];
                          return MainCategoryItem(
                            isHome: true,
                            bannersModel: category,
                          );
                        },
                      )),
                ),
              ],
            );
          }
          else {
            return const Center();
          }
        },
      ),
    );
  }
}
