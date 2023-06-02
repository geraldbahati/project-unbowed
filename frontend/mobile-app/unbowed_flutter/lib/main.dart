import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/animations/exclamation.dart';
import 'package:unbowed_flutter/presentation/animations/slide_in.dart';
import 'package:unbowed_flutter/presentation/styles/theme.dart';
import 'package:unbowed_flutter/presentation/views/chat_pages/chatroom.dart';
import 'package:unbowed_flutter/presentation/views/home_pages/home_screen.dart';
import 'package:unbowed_flutter/presentation/views/landing_pages/landing2.dart';
import 'package:unbowed_flutter/presentation/views/landing_pages/landing_page_view.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/profile_box.dart';
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
              theme: lightTheme,
              darkTheme: darkTheme,

              // onGenerateRoute: _appRouter.onGenerateRoute,
              // home: const LandingView(),
              home: HomeView(),
            ));
  }
}
