import 'package:aslol/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/core/bloc/global_cubit/global_cubit.dart';
import 'package:aslol/core/bloc/global_cubit/global_state.dart';
import 'package:aslol/core/enum/language.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/language/language_item_design.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  Language? selectedLang;

  @override
  void initState() {
    selectedLang = context.read<GlobalCubit>().language;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.bodyHeight * .5,
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: SizeConfig.bodyHeight * .45,
          width: SizeConfig.screenWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Scaffold(
              body: Padding(
                padding: screenPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.verticalSpace,
                    AppText(
                      text: context.localizations.chooseYourLang,
                      fontWeight: FontWeight.w500,
                      textSize: 16,
                    ),
                    20.verticalSpace,
                    LanguageItemDesign(
                      language: context.localizations.arabic,
                      isSelected: selectedLang == Language.arabic,
                      callback: () =>
                          setState(() => selectedLang = Language.arabic),
                    ),
                    20.verticalSpace,
                    LanguageItemDesign(
                      language: context.localizations.english,
                      isSelected: selectedLang == Language.english,
                      callback: () =>
                          setState(() => selectedLang = Language.english),
                    ),
                    30.verticalSpace,
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * .04),
                      child: BlocListener<GlobalCubit, GlobalState>(
                        listenWhen: (previous, current) => previous != current,
                        listener: (context, state) {
                          if (state is ChangeLocaleState) {
                            Navigator.pop(context);
                          }
                        },
                        child: CustomButton(
                          isActive: selectedLang != null,
                          text: context.localizations.done,
                          press: () => context
                              .read<GlobalCubit>()
                              .changeLanguage(lang: selectedLang!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
