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

class ChatReceived extends ChannelState {
  final MessageReceive message;

  ChatReceived({
    required this.message,
  });
}
