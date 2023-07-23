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
  final bool isLoading;

  ChatRoomsLoading({
    this.exception,
    required this.isLoading,
  });
}

class ChatRoomsLoaded extends ChatState {
  final List<ChatroomModel> chatRooms;

  ChatRoomsLoaded({
    required this.chatRooms,
  });
}

class ChatStateChange extends ChatState {}
