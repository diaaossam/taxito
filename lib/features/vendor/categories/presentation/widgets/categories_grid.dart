import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../captain/app/data/models/generic_model.dart';
import '../cubit/categories_cubit.dart';
import '../pages/add_edit_category_screen.dart';
import '../pages/categories_details_screen.dart';

class CategoriesGrid extends StatefulWidget {
  const CategoriesGrid({super.key});

  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  void initState() {
    final bloc = context.read<CategoriesCubit>();
    bloc.pagingController.addPageRequestListener((pageKey) {
      bloc.fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final bloc = context.read<CategoriesCubit>();
        return RefreshIndicator(
          onRefresh: () async => bloc.pagingController.refresh(),
          child: CustomScrollView(
            slivers: [
              PagedSliverGrid<int, GenericModel>(
                pagingController: bloc.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, item, index) {
                    return InkWell(
                      onTap: () => context.navigateTo(
                        CategoriesDetailsScreen(genericModel: item),
                      ),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 300 + (index * 50)),
                        curve: Curves.easeOutCubic,
                        builder: (context, t, child) => Transform.translate(
                          offset: Offset(0, (1 - t) * 20),
                          child: Opacity(opacity: t, child: child),
                        ),
                        child: Card(
                          child: Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: AppText(
                                    text: item.title ?? "",
                                    textSize: 12,
                                    maxLines: 2,
                                    align: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: InkWell(
                                  onTap: () async {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return Padding(
                                          padding: screenPadding(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height:
                                                    SizeConfig.bodyHeight * .02,
                                              ),
                                              const Align(
                                                alignment:
                                                    AlignmentDirectional.topEnd,
                                                child: CloseButton(),
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.bodyHeight * .04,
                                              ),
                                              CustomButton(
                                                text:
                                                    context.localizations.edit,
                                                press: () {
                                                  context.navigateTo(
                                                    AddEditCategoryScreen(
                                                      model: item,
                                                    ),
                                                  );
                                                },
                                              ),
                                              20.verticalSpace,
                                              CustomButton(
                                                backgroundColor:
                                                    Colors.transparent,
                                                textColor:
                                                    context.colorScheme.error,
                                                text: context
                                                    .localizations
                                                    .delete,
                                                press: () {
                                                  context
                                                      .read<CategoriesCubit>()
                                                      .remove(id: item.id ?? 0);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.bodyHeight * .04,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.more_vert, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (context) => Opacity(
                    opacity: 0.4,
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.bodyHeight * .2),
                        AppImage.asset(Assets.icons.category2, size: 100),
                        SizedBox(height: SizeConfig.bodyHeight * .03),
                        AppText(
                          text: context.localizations.noCategoriesFound,
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
