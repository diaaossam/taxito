import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/order/data/models/product_params.dart';
import 'package:aslol/features/search/presentation/cubit/filter/filter_cubit.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_size.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/image_picker/app_image.dart';
import '../../../main/data/models/banners_model.dart';

class MainFilterGridDesign extends StatefulWidget {
  const MainFilterGridDesign({
    super.key,
  });

  @override
  State<MainFilterGridDesign> createState() => _MainFilterGridDesignState();
}

class _MainFilterGridDesignState extends State<MainFilterGridDesign> {
  List<BannersModel> banners = [
    BannersModel(id: 1, title: S.current.highestRated),
    BannersModel(id: 2, title: S.current.recentlyAdded),
    BannersModel(id: 3, title: S.current.showAvailableProductsFirst),
    BannersModel(id: 4, title: S.current.mostPrice),
    BannersModel(id: 5, title: S.current.lowestPrice),
  ];
  num? selectedFilterId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        final bloc = context.read<FilterCubit>();
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: banners.map((filter) {
            bool isSelected = selectedFilterId == filter.id;
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedFilterId == filter.id) {
                    selectedFilterId = null;
                    bloc.params = ProductParams(
                      pageKey: bloc.params.pageKey,
                    );
                  } else {
                    selectedFilterId = filter.id;
                    bloc.params = ProductParams(
                      pageKey: bloc.params.pageKey,
                      sortBy: _getSortBy(filter.id),
                    );
                  }
                });
                bloc.updateFilterParams(updatedParams: bloc.params);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * .03, vertical: 10),
                decoration: BoxDecoration(
                    color: isSelected
                        ? context.colorScheme.onPrimary
                        : const Color(0xffF8F8F8),
                    border: Border.all(
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.outline),
                    borderRadius: BorderRadius.circular(14)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    8.horizontalSpace,
                    if (isSelected)
                      AppImage.asset(
                        Assets.icons.radio,
                      )
                    else
                      AppImage.asset(
                        Assets.icons.radioEmpty,
                      ),
                    10.horizontalSpace,
                    AppText(
                      text: filter.title ?? "",
                      maxLines: 2,
                      textSize: 11,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  _getSortBy(num? id) {
    if (id == 1) {
      return 'rating_desc';
    } else if (id == 2) {
      return 'newest';
    } else if (id == 3) {
      return 'is_available';
    } else if (id == 4) {
      return 'price_asc';
    } else if (id == 5) {
      return 'price_desc';
    }
  }
}
