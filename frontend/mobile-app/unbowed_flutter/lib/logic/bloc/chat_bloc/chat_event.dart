part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class LoadChats extends ChatEvent {
  final String chatRoomId;

  LoadChats({
    required this.chatRoomId,
  });
}

class DeleteChat extends ChatEvent {
  final String messageId;

  DeleteChat({
    required this.messageId,
  });
}

class ConnectSocket extends ChatEvent {
  final String chatRoomId;

  ConnectSocket({
    required this.chatRoomId,
  });
}

class DisconnectSocket extends ChatEvent {}
