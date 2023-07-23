import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/chatroom/chatroom_model.dart';
import '../../../data/models/messages/message_model.dart';
import '../../../data/models/messages/message_receive.dart';
import '../../../data/provider/chat_provider.dart';
import '../../../presentation/widgets/containers/chats/chat_logic.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<Message> _loadChats = [];
  ChatBloc(ChatProvider provider) : super(ChatInitial()) {
    on<LoadChats>((event, emit) async {
      emit(ChatLoading(isLoading: true));
      try {
        final List<Message> messages;
        if (_loadChats.isEmpty) {
          messages = await provider.loadChats(
            chatRoomId: event.chatRoomId,
          );
        } else {
          print('loading from cache');
          messages = _loadChats;
        }

        emit(ChatLoading(isLoading: false));

        for (Message message in messages.reversed) {
          add(ReceiveStoreChat(message: message));
        }
      } catch (e) {
        emit(ChatLoading(
          isLoading: false,
          exception: e as Exception,
        ));
      }
    });

    on<ReceiveChat>((event, emit) {
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
        isSamePerson = currentState.chat.message.sender!.username ==
            event.message.username;

        if (isSamePerson) {
          bool isFirst = currentState.chat.message.isFirst;
          bool isMiddle = currentState.chat.message.isMiddle;
          bool isLast = currentState.chat.message.isLast;

          if (!(isFirst || isMiddle || isLast)) {
            currentState.chat.message.isFirst = true;
            message.isLast = true;
          } else if (isFirst) {
            message.isLast = true;
          } else if (isLast) {
            currentState.chat.message.isMiddle = true;
            currentState.chat.message.isLast = false;
            message.isLast = true;
          } else {
            currentState.chat.message.isFirst = false;
            currentState.chat.message.isMiddle = false;
            currentState.chat.message.isLast = true;
          }
        }
      }

      ChatLogic chat = ChatLogic(
        message: message,
        isSamePerson: isSamePerson,
      );

      emit(ChatReceived(chat: chat, shouldRefresh: isSamePerson));
    });

    on<ReceiveStoreChat>((event, emit) {
      bool isSamePerson = false;

      if (state is ChatReceived) {
        final ChatReceived currentState = state as ChatReceived;
        isSamePerson = currentState.chat.message.sender!.username ==
            event.message.sender!.username;

        if (isSamePerson) {
          bool isFirst = currentState.chat.message.isFirst;
          bool isMiddle = currentState.chat.message.isMiddle;
          bool isLast = currentState.chat.message.isLast;

          if (!(isFirst || isMiddle || isLast)) {
            currentState.chat.message.isFirst = true;
            event.message.isLast = true;
          } else if (isFirst) {
            event.message.isLast = true;
          } else if (isLast) {
            currentState.chat.message.isMiddle = true;
            currentState.chat.message.isLast = false;
            event.message.isLast = true;
          } else {
            currentState.chat.message.isFirst = false;
            currentState.chat.message.isMiddle = false;
            currentState.chat.message.isLast = true;
          }
        }
      }

      ChatLogic chat = ChatLogic(
        message: event.message,
        isSamePerson: isSamePerson,
      );

      emit(ChatReceived(chat: chat, shouldRefresh: isSamePerson));
    });

    on<LoadChatRooms>((event, emit) async {
      emit(ChatRoomsLoading(isLoading: true));
      try {
        final List<ChatroomModel> chatRooms = await provider.laodChatrooms();
        emit(ChatRoomsLoading(isLoading: false));
        emit(ChatRoomsLoaded(chatRooms: chatRooms));
      } on Exception catch (e) {
        emit(ChatRoomsLoading(
          isLoading: false,
          exception: e,
        ));
      }
    });
  }
}
