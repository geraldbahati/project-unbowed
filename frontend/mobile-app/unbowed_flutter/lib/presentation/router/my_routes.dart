import 'package:flutter/material.dart';
import 'package:unbowed_flutter/presentation/router/page_transitions.dart';

import '../views/chat_pages/chatroom.dart';
import '../views/home_pages/chat_screen.dart';
import '../views/home_pages/home_page_view.dart';
import '../views/landing_pages/landing_page_view.dart';
import '../views/register_pages/register_page.dart';
import 'route_mapping.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeRoute:
        return CircularPageRoute(
          builder: (_) => const HomePageView(),
          durationInMillisecond: 1000,
        );

      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case landingRoute:
        return MaterialPageRoute(builder: (_) => const LandingView());

      case chatRoute:
        return MaterialPageRoute(builder: (_) => const ChatScreen());

      case chatRoomRoute:
        return CircularPageRoute(
          builder: (_) => const ChatroomPageWidget(),
          durationInMillisecond: 300,
        );

      default:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
    }
  }

  void dispose() {}
}
