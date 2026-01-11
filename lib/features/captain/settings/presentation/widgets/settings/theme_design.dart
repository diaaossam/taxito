import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxito/config/theme/theme_helper.dart';
import 'package:taxito/core/bloc/global_cubit/global_cubit.dart';
import 'package:taxito/core/bloc/global_cubit/global_state.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';

class ThemeRowDesign extends StatelessWidget {
  const ThemeRowDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * .02,
          vertical: SizeConfig.bodyHeight * .01),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Center(
                child: SvgPicture.asset(
              Assets.icons.gallery,
              colorFilter: ThemeHelper().setUpIconsColor(context: context),
            )),
            SizedBox(
              width: SizeConfig.screenWidth * .02,
            ),
            Expanded(
                child: AppText(
              text: context.localizations.darkMode,
              fontWeight: FontWeight.w700,
              textSize: 18,
            )),
            BlocBuilder<GlobalCubit, GlobalState>(
              builder: (context, state) {
                final bloc = context.read<GlobalCubit>();
                return Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        activeColor: context.colorScheme.primary,
                        value: bloc.themeMode == ThemeMode.dark,
                        onChanged: (value) => bloc.chooseAppTheme(
                            theme: bloc.themeMode == ThemeMode.dark
                                ? ThemeMode.light
                                : ThemeMode.dark)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
