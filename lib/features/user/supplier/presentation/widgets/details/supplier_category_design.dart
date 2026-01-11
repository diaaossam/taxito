import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/supplier/presentation/cubit/supplier_details/supplier_details_bloc.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupplierCategoryDesign extends StatelessWidget {
  const SupplierCategoryDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierDetailsBloc, SupplierDetailsState>(
      builder: (context, state) {
        final bloc = context.read<SupplierDetailsBloc>();
        return SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      bloc.categories.length,
                      (index) {
                        final isSelected = bloc.categories[index] == bloc.model;
                        return InkWell(
                          onTap: () => bloc.add(SelectCategoryEvent(genericModel: bloc.categories[index])),
                          child: Container(
                              margin: index == 0
                                  ? null
                                  : const EdgeInsetsDirectional.only(start: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.h, vertical: 8),
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? context.colorScheme.onPrimary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: isSelected
                                          ? context.colorScheme.primary
                                          : context.colorScheme.outline)),
                              child: AppText(
                                  text: bloc.categories[index].title ?? "")),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              AppText(
                text: bloc.model?.title ?? "",
                textSize: 16,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        );
      },
    );
  }
}
