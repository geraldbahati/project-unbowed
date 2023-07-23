import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unbowed_flutter/logic/cubit/channel_cubit/channel_cubit.dart';

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
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _chatBloc,
              ),
              BlocProvider.value(
                value: _authBloc,
              ),
            ],
            child: const ChatScreen(),
          ),
        );

      case chatRoomRoute:
        final chatRoomId = routeSettings.arguments as String;
        return CircularPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ChannelCubit>(
                create: (context) => ChannelCubit(ChatService()),
              ),
              BlocProvider.value(
                value: _chatBloc,
              ),
              BlocProvider.value(
                value: _authBloc,
              ),
            ],
            child: ChatroomPageWidget(
              chatRoomId: chatRoomId,
            ),
          ),
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
