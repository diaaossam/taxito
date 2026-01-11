import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/validitor_extention.dart';
import 'package:aslol/core/utils/app_constant.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/settings/presentation/bloc/user_suggestion/user_suggestion_bloc.dart';
import 'package:aslol/widgets/app_drop_down.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/custom_sliver_app_bar.dart';
import 'package:aslol/widgets/custom_text_form_field.dart';

class SuggestionBody extends StatefulWidget {
  const SuggestionBody({super.key});

  @override
  State<SuggestionBody> createState() => _SuggestionBodyState();
}

class _SuggestionBodyState extends State<SuggestionBody> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSuggestionBloc, UserSuggestionState>(
      listener: (context, state) {
        if (state is SendSuggestionTypesSuccess) {
          Navigator.pop(context);
          AppConstant.showCustomSnakeBar(context, state.msg, true);
        } else if (state is SendSuggestionTypesFailure) {
          AppConstant.showCustomSnakeBar(context, state.error, false);
        }
      },
      builder: (context, state) {
        final bloc = context.read<UserSuggestionBloc>();
        return Scaffold(
          body: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: screenPadding(),
              child: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    title: context.localizations.userSuggestions,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: SizeConfig.bodyHeight * .04,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AppText(
                      text: context.localizations.suggestionBody,
                      color: context.colorScheme.surface,
                      maxLines: 5,
                      align: TextAlign.start,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: SizeConfig.bodyHeight * .04,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AppText(
                      text: context.localizations.chooseSuggestion,
                      fontWeight: FontWeight.bold,
                      textSize: 18,
                      align: TextAlign.start,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AppDropDown(
                        name: "suggestion",
                        validator: FormBuilderValidators.required(
                            errorText: context.localizations.validation),
                        hint: context.localizations.chooseSuggestion,
                        items: bloc.suggestionsList
                            .map((e) => DropdownMenuItem(
                                value: e.id,
                                child: AppText(text: e.title ?? '')))
                            .toList()),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: SizeConfig.bodyHeight * .04,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AppText(
                      text: context.localizations.enterMessage,
                      fontWeight: FontWeight.bold,
                      textSize: 18,
                      align: TextAlign.start,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: screenPadding(),
                      child: CustomTextFormField(
                        name: "message",
                        maxLines: 6,
                        hintText: context.localizations.enterMessageHere,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: SizeConfig.bodyHeight * .02,
                left: SizeConfig.screenWidth * .04,
                right: SizeConfig.screenWidth * .04),
            child: CustomButton(
                isLoading: state is SendSuggestionTypesLoading,
                text: context.localizations.send,
                press: () async {
                  if (!_formKey.currentState!.saveAndValidate()) {
                    return;
                  }
                  final suggestionId = _formKey.fieldValue("suggestion");
                  final message = _formKey.fieldValue("message");
                  bloc.add(SendSuggestionEvent(
                    other: message,
                    id: suggestionId,
                  ));
                }),
          ),
        );
      },
    );
  }
}
