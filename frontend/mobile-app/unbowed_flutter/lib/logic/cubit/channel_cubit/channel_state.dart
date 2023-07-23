part of 'channel_cubit.dart';

@immutable
abstract class ChannelState {}

class ChannelInitial extends ChannelState {}

class ChannelConnecting extends ChannelState {
  final Exception? exception;
  final bool isConnecting;

  ChannelConnecting({
    this.exception,
    required this.isConnecting,
  });
}

class ChannelConnected extends ChannelState {
  final IOWebSocketChannel channel;

  ChannelConnected({
    required this.channel,
  });
}

class MessageReceived extends ChannelState {
  final MessageReceive message;

  MessageReceived({
    required this.message,
  });
}

class TypingState extends ChannelState {
  final bool isTyping;
  final String username;

  TypingState({
    required this.isTyping,
    required this.username,
  });
}

class OnlineUsers extends ChannelState {
  final OnlineUsersResponse onlineStatus;

  OnlineUsers({
    required this.onlineStatus,
  });
}
