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

class DisconnectSocket extends ChatEvent {}

class ReceiveChat extends ChatEvent {
  final MessageReceive message;

  ReceiveChat({
    required this.message,
  });
}

class ReceiveStoreChat extends ChatEvent {
  final Message message;

  ReceiveStoreChat({
    required this.message,
  });
}
