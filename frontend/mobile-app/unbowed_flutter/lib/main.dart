import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'presentation/router/my_routes.dart';
import 'presentation/styles/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  void dispose() {
    // TODO: implement dispose
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Unbowed',
              theme: lightTheme,
              darkTheme: darkTheme,

              onGenerateRoute: _appRouter.onGenerateRoute,
              // home: const LandingView(),
              // home: LandingView(),
            ));
  }
}
