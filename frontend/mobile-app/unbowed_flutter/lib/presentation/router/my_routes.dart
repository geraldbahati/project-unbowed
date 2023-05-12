import 'package:flutter/material.dart';

import '../views/register_pages/register_page.dart';
import 'route_mapping.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      default:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
    }
  }

  void dispose() {}
}
