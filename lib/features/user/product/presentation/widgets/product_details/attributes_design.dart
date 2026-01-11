import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/product/data/models/attributes_model.dart';
import 'package:aslol/features/product/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributesDesign extends StatelessWidget {
  final List<AttributesModel> attributes;

  const AttributesDesign({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final cubit = context.read<ProductDetailsCubit>();
        final selectedValues = cubit.selectedValues;
        return Column(
          children: attributes.map((attribute) {
            final isColor = attribute.isColor == 1;
            final isMultiple = attribute.isMultiple == 1;
            final isRequired = attribute.isRequired == 1;
            if (attribute.values != null && attribute.values!.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(
                        text: attribute.title ?? '',
                        fontWeight: FontWeight.w600,
                        textSize: 14,
                      ),
                      if (isRequired)
                        AppText.hint(
                            text: " (${context.localizations.isRequired})")
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: attribute.values!.first.image != null && attribute.values!.first.image!.isNotEmpty
                        ? SizeConfig.bodyHeight * .15
                        : SizeConfig.bodyHeight * .11,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: attribute.values?.length ?? 0,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final value = attribute.values![index];
                        final selectedList =
                            selectedValues[attribute.attributeId] ?? [];
                        final isSelected =
                            selectedList.contains(value.attributeValueId);
                        return InkWell(
                          onTap: () {
                            cubit.toggleAttributeValue(
                              attributeId: attribute.attributeId!,
                              valueId: value.attributeValueId!,
                              isMultiple: isMultiple,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.orange
                                    : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              color: isSelected
                                  ? Colors.orange.withValues(alpha: 0.1)
                                  : Colors.transparent,
                            ),
                            child: isColor
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(int.parse(
                                            '0xff${value.hexCode?.replaceAll('#', '') ?? '000000'}')),
                                        radius: 15,
                                      ),
                                      if (value.price != null &&
                                          value.price != 0) ...[
                                        const SizedBox(height: 10),
                                        AppText.hint(
                                            text:
                                                "+ ${value.price.toString()}"),
                                      ]
                                    ],
                                  )
                                : value.image != null && value.image!.isNotEmpty
                                    ? Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.network(
                                              value.image!,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          AppText(text: value.title ?? ''),
                                          if (value.price != null &&
                                              value.price != 0) ...[
                                            const SizedBox(height: 6),
                                            AppText.hint(
                                                text:
                                                    "+ ${value.price.toString()}"),
                                          ]
                                        ],
                                      )
                                    : Center(
                                        child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AppText(
                                            text: value.title ?? '',
                                            fontWeight: FontWeight.w600,
                                          ),
                                          if (value.price != null &&
                                              value.price != 0) ...[
                                            const SizedBox(height: 6),
                                            AppText.hint(
                                                text:
                                                    "+ ${value.price.toString()}"),
                                          ]
                                        ],
                                      )),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            } else {
              return const Center();
            }
          }).toList(),
        );
      },
    );
  }
}
