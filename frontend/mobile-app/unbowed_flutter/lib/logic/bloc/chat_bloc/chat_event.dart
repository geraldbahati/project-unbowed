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

class LoadChatRooms extends ChatEvent {}

class SyncChatRooms extends ChatEvent {
  final List<DatabaseChatRoomModel> chatRooms;

  SyncChatRooms({
    required this.chatRooms,
  });
}

class SyncChats extends ChatEvent {
  final List<DatabaseMessageModel> chats;

  SyncChats({
    required this.chats,
  });
}

class UpdateMessageDatabase extends ChatEvent {}

class UpdateChatRoomDatabase extends ChatEvent {}

class LoadDbMessages extends ChatEvent {
  final String chatRoomId;

  LoadDbMessages({
    required this.chatRoomId,
  });
}

class LoadDbChatRooms extends ChatEvent {}

class ReceiveChatRooms extends ChatEvent {
  final List<DatabaseChatRoomModel> chatRooms;

  ReceiveChatRooms({
    required this.chatRooms,
  });
}
