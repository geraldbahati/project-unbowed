import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unbowed_flutter/logic/bloc/auth_bloc/auth_bloc.dart';

import '../../router/route_mapping.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkUserExistence();
  }

  Future<void> _checkUserExistence() async {
    // Add a delay of 2 seconds (adjust the duration as needed)
    await Future.delayed(Duration(seconds: 2));

    context.read<AuthBloc>().add(AuthEventInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistered) {
            Navigator.of(context).pushReplacementNamed(homeRoute);
          } else {
            Navigator.of(context).pushReplacementNamed(landingRoute);
          }
        },
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
