import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/animations/exclamation.dart';
import 'package:unbowed_flutter/presentation/animations/scroll_down.dart';
import 'package:unbowed_flutter/presentation/views/landing_pages/landing2.dart';
import 'package:unbowed_flutter/presentation/views/landing_pages/landing_page_view.dart';
import 'presentation/router/my_routes.dart';
import 'presentation/views/landing_pages/landing1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouter _appRouter = AppRouter();

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
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              // onGenerateRoute: _appRouter.onGenerateRoute,
              home: const LandingView(),
              // home: ScrollDownAnimation(),
            ));
  }
}
