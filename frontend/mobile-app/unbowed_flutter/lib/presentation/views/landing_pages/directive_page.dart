import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unbowed_flutter/logic/bloc/auth_bloc/auth_bloc.dart';

import '../home_pages/home_page_view.dart';

class DirectivePage extends StatelessWidget {
  const DirectivePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventInitial());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthRegistered) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<AuthBloc>()),
            ],
            child: const HomePageView(),
          );
        } else if (state is AuthUnregistered) {
          return const HomePageView();
        } else {
          return const HomePageView();
        }
      },
    );
  }
}
