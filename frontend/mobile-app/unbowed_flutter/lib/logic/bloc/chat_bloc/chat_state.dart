// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class ChatReceived extends ChatState {
  final Message message;

  ChatReceived({
    required this.message,
  });
}

class PreviousChatStored extends ChatState {
  final Message message;

  PreviousChatStored({
    required this.message,
  });
}

class ChatInstanceState extends ChatState {
  final Message message;
  final bool isSamePerson;

  ChatInstanceState({
    required this.message,
    required this.isSamePerson,
  });
}
