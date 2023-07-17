part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {
  final Exception? exception;
  final bool isLoading;

  ChatLoading({
    this.exception,
    required this.isLoading,
  });
}

class ChatLoaded extends ChatState {
  final List<Message> messages;

  ChatLoaded({
    required this.messages,
  });
}

class SocketConnecting extends ChatState {
  final Exception? exception;
  final bool isConnecting;

  SocketConnecting({
    this.exception,
    required this.isConnecting,
  });
}

class SocketConnected extends ChatState {
  final IOWebSocketChannel channel;

  SocketConnected({
    required this.channel,
  });
}

class SocketDisconnecting extends ChatState {
  final bool isDisconnected;

  SocketDisconnecting({
    required this.isDisconnected,
  });
}

class ChatReceived extends ChatState {
  final MessageReceive message;

  ChatReceived({
    required this.message,
  });
}
