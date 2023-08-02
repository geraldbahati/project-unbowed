part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatError extends ChatState {
  final Exception exception;

  ChatError({
    required this.exception,
  });
}

class ChatReceived extends ChatState {
  final ChatLogic chat;
  final bool shouldRefresh;

  ChatReceived({
    required this.chat,
    this.shouldRefresh = false,
  });
}

class ChatRoomsLoading extends ChatState {
  final Exception? exception;

  ChatRoomsLoading({
    this.exception,
  });
}

class ChatRoomsLoaded extends ChatState {
  final List<ChatroomModel> chatRooms;

  ChatRoomsLoaded({
    required this.chatRooms,
  });
}

class ChatRoomsSynced extends ChatState {}

class ChatsSynced extends ChatState {}

class ChatRoomDatabaseUpdated extends ChatState {}

class MessageDatabaseUpdated extends ChatState {}

class DbMessagesLoaded extends ChatState {
  final List<DatabaseMessageModel> messages;

  DbMessagesLoaded({
    required this.messages,
  });
}

class DbChatRoomsLoaded extends ChatState {
  final List<DatabaseChatRoomModel> chatRooms;

  DbChatRoomsLoaded({
    required this.chatRooms,
  });
}

class ChatroomsRecieved extends ChatState {
  final List<ChatroomModel> chatRooms;

  ChatroomsRecieved({
    required this.chatRooms,
  });
}
