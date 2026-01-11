import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../../attributes/presentation/cubit/attributes_cubit.dart';
import '../../../data/models/attribute_model.dart';
import '../../pages/add_attribute_screen.dart';
import '../attribute_actions_modal.dart';
import '../attribute_item.dart';
import '../delete_confirmation_modal.dart';

class MainAttributeBody extends StatefulWidget {
  const MainAttributeBody({super.key});

  @override
  State<MainAttributeBody> createState() => _MainAttributeBodyState();
}

class _MainAttributeBodyState extends State<MainAttributeBody> {
  @override
  void initState() {
    final bloc = context.read<AttributesCubit>();
    bloc.pagingController.addPageRequestListener((page) {
      bloc.fetchPage(page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttributesCubit, AttributesState>(
      builder: (context, state) {
        final bloc = context.read<AttributesCubit>();
        return Padding(
          padding: screenPadding(),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomButton(
                text: context.localizations.addNewAttribute,
                press: () {
                  context.navigateTo(
                    const AddAttributeScreen(),
                    callback: (p0) {
                      if (p0 != null && p0) {
                        context
                            .read<AttributesCubit>()
                            .pagingController
                            .refresh();
                      }
                    },
                  );
                },
                backgroundColor: Colors.transparent,
                textColor: context.colorScheme.primary,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => bloc.pagingController.refresh(),
                  child: PagedListView<int, AttributeModel>(
                    pagingController: bloc.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<AttributeModel>(
                      itemBuilder: (context, attribute, index) => AttributeItem(
                        attribute: attribute,
                        onTap: () => _showAttributeActions(
                          attribute: attribute,
                          cubit: bloc,
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => Opacity(
                        opacity: 0.4,
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.bodyHeight * .2),
                            AppImage.asset(Assets.icons.product, size: 100),
                            SizedBox(height: SizeConfig.bodyHeight * .03),
                            AppText(
                              text: context.localizations.noAttributesFound,
                              textSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAttributeActions({
    required AttributeModel attribute,
    required AttributesCubit cubit,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => AttributeActionsModal(
        onEdit: () =>
            context.navigateTo(AddAttributeScreen(attributeModel: attribute)),
        onDelete: () =>
            _showDeleteConfirmation(attribute: attribute, cubit: cubit),
      ),
    );
  }

  void _showDeleteConfirmation({
    required AttributeModel attribute,
    required AttributesCubit cubit,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => DeleteConfirmationModal(
        onConfirm: () {
          cubit.remove(id: attribute.id!);
          cubit.pagingController.refresh();
        },
      ),
    );
  }
}
