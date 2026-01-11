import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/config/dependencies/injectable_dependencies.dart';
import 'package:aslol/features/settings/presentation/bloc/user_suggestion/user_suggestion_bloc.dart';
import 'package:aslol/features/settings/presentation/widgets/suggestion/suggestion_body.dart';

class UserSuggestionScreen extends StatelessWidget {
  const UserSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<UserSuggestionBloc>()..add(GetAllSuggestionsType()),
      child: const Scaffold(
        body: SuggestionBody(),
      ),
    );
  }
}
