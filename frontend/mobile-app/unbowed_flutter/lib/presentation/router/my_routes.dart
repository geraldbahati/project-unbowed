import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/provider/chat_provider.dart';
import '../../data/provider/user_provider.dart';
import '../../logic/bloc/auth_bloc/auth_bloc.dart';
import '../../logic/bloc/chat_bloc/chat_bloc.dart';
import '../views/chat_pages/chatroom.dart';
import '../views/home_pages/chat_screen.dart';
import '../views/home_pages/home_page_view.dart';
import '../views/landing_pages/landing_page_view.dart';
import '../views/register_pages/otp_page.dart';
import '../views/register_pages/phone_auth_page.dart';
import 'page_transitions.dart';
import 'route_mapping.dart';

class AppRouter {
  final AuthBloc _authBloc = AuthBloc(UserService());
  final ChatBloc _chatBloc = ChatBloc(ChatService());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeRoute:
        return CircularPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider.value(
                value: _chatBloc,
              ),
            ],
            child: const HomePageView(),
          ),
          durationInMillisecond: 1000,
        );

      case phoneAuthRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc,
            child: const PhoneAuthPageWidget(),
          ),
        );

      case confirmOtpRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc,
            child: const OtpPageWidget(),
          ),
        );

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
        return MaterialPageRoute(builder: (_) => const LandingView());
    }
  }

  void dispose() {
    _authBloc.close();
    _chatBloc.close();
  }
}
