import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:unbowed_flutter/database/services/chatroom_service.dart';

import '../../../data/models/chatroom/chatroom_model.dart';
import '../../../data/models/messages/message_model.dart';
import '../../../data/models/messages/message_receive.dart';
import '../../../data/provider/chat_provider.dart';
import '../../../database/models/chatroom_db_model.dart';
import '../../../database/models/message_db_model.dart';
import '../../../database/services/message_service.dart';
import '../../../presentation/widgets/containers/chats/chat_logic.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatProvider provider;

  ChatBloc({required this.provider}) : super(ChatInitial()) {
    on<LoadChats>(_loadChats);
    on<ReceiveChat>(_receiveChat);
    on<ReceiveStoreChat>(_receiveStoreChat);
    on<LoadChatRooms>(_loadChatRooms);
    on<LoadDbChatRooms>(_loadDbChatRooms);
    on<ReceiveChatRooms>(_receiveChatRooms);
  }

// Methods to handle events
  Future<void> _loadChats(LoadChats event, Emitter<ChatState> emit) async {
    {
      // Instantiate the MessageDbService with the chatRoomId here
      MessageDbService messageDbService =
          MessageDbService(event.chatRoomId as int);
      await messageDbService.init();

      emit(ChatLoading());
      try {
        final List<Message> messages = await provider.loadChats(
          chatRoomId: event.chatRoomId,
        );

        messageDbService.saveAllMessages(
          messages: dbMessagesFromMessages(messages),
        );

        for (Message message in messages.reversed) {
          add(ReceiveStoreChat(message: message));
        }
      } on Exception catch (e) {
        emit(ChatError(exception: e));
      }
    }
  }

  void _receiveChat(ReceiveChat event, Emitter<ChatState> emit) {
    bool isSamePerson = false;

    Message message = Message(
      description: event.message.message,
      sender: Sender(
        username: event.message.username,
      ),
      created: event.message.created,
    );

    if (state is ChatReceived) {
      final ChatReceived currentState = state as ChatReceived;
      isSamePerson =
          currentState.chat.message.sender!.username == event.message.username;

      if (isSamePerson) {
        setChatMessagePosition(currentState.chat.message, message);
      }
    }

    ChatLogic chat = ChatLogic(
      message: message,
      isSamePerson: isSamePerson,
    );

    emit(ChatReceived(chat: chat, shouldRefresh: isSamePerson));
  }

  void _receiveStoreChat(ReceiveStoreChat event, Emitter<ChatState> emit) {
    bool isSamePerson = false;

    if (state is ChatReceived) {
      final ChatReceived currentState = state as ChatReceived;
      isSamePerson = currentState.chat.message.sender!.username ==
          event.message.sender!.username;

      if (isSamePerson) {
        setChatMessagePosition(currentState.chat.message, event.message);
      }
    }

    ChatLogic chat = ChatLogic(
      message: event.message,
      isSamePerson: isSamePerson,
    );

    emit(ChatReceived(chat: chat, shouldRefresh: isSamePerson));
  }

  Future<void> _loadChatRooms(
      LoadChatRooms event, Emitter<ChatState> emit) async {
    emit(ChatRoomsLoading());
    try {
      final List<ChatroomModel> chatRooms = await provider.loadChatrooms();
      ChatroomDbService chatroomDbService = ChatroomDbService();
      chatroomDbService.init();

      chatroomDbService.saveAllChatRooms(
          chatRooms: dbChatroomsFromChatrooms(chatRooms));

      emit(ChatRoomsLoaded(chatRooms: chatRooms));
    } on Exception catch (e) {
      emit(ChatRoomsLoading(exception: e));
    }
  }

  Future<void> _loadDbChatRooms(
      LoadDbChatRooms event, Emitter<ChatState> emit) async {
    emit(ChatRoomsLoading());
    try {
      ChatroomDbService chatroomDbService = ChatroomDbService();
      chatroomDbService.init();

      chatroomDbService.chatRoomsStream.listen((chatRooms) {
        add(ReceiveChatRooms(chatRooms: chatRooms));
      });
    } on Exception catch (e) {
      emit(ChatRoomsLoading(exception: e));
    }
  }

  void _receiveChatRooms(ReceiveChatRooms event, Emitter<ChatState> emit) {
    emit(ChatRoomsLoaded(
      chatRooms: dbChatroomsToChatrooms(event.chatRooms),
    ));
  }

  // utils
  void setChatMessagePosition(Message oldMessage, Message newMessage) {
    bool isFirst = oldMessage.isFirst;
    bool isMiddle = oldMessage.isMiddle;
    bool isLast = oldMessage.isLast;

    if (!(isFirst || isMiddle || isLast)) {
      oldMessage.isFirst = true;
      newMessage.isLast = true;
    } else if (isFirst) {
      newMessage.isLast = true;
    } else if (isLast) {
      oldMessage.isMiddle = true;
      oldMessage.isLast = false;
      newMessage.isLast = true;
    } else {
      oldMessage.isFirst = false;
      oldMessage.isMiddle = false;
      oldMessage.isLast = true;
    }
  }
}
