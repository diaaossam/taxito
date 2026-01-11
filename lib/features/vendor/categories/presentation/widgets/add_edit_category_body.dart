import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_size.dart';

import '../../../../captain/app/data/models/generic_model.dart';
import '../cubit/categories_cubit.dart';

class AddEditCategoryBody extends StatefulWidget {
  final GenericModel? model;

  const AddEditCategoryBody({super.key, this.model});

  @override
  State<AddEditCategoryBody> createState() => _AddEditCategoryBodyState();
}

class _AddEditCategoryBodyState extends State<AddEditCategoryBody> {
  final TextEditingController _ar = TextEditingController();
  final TextEditingController _en = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      _ar.text = widget.model!.titleAr ?? "";
      _en.text = widget.model!.titleEn ?? "";
    }
  }

  @override
  void dispose() {
    _ar.dispose();
    _en.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.bodyHeight * .02),
          CustomTextFormField(
            controller: _ar,
            title: context.localizations.arabicCategoryName,
            label: context.localizations.arabicCategoryName,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.localizations.validation
                : null,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          CustomTextFormField(
            controller: _en,
            title: context.localizations.englishCategoryName,
            label: context.localizations.englishCategoryName,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.localizations.validation
                : null,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .03),
          BlocConsumer<CategoriesCubit, CategoriesState>(
            listener: (context, state) {
              if (state is CategoriesActionSuccess) {
                Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              final isLoading = state is CategoriesActionLoading;
              return CustomButton(
                text: widget.model == null
                    ? context.localizations.save
                    : context.localizations.update,
                isLoading: isLoading,
                press: () {
                  if (widget.model == null) {
                    context.read<CategoriesCubit>().add(
                      ar: _ar.text.trim(),
                      en: _en.text.trim(),
                    );
                  } else {
                    context.read<CategoriesCubit>().update(
                      id: widget.model!.id ?? 0,
                      ar: _ar.text.trim(),
                      en: _en.text.trim(),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
