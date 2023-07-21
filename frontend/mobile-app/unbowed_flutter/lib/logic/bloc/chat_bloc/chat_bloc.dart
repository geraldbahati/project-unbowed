import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/messages/message_model.dart';
import '../../../data/models/messages/message_receive.dart';
import '../../../data/provider/chat_provider.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(ChatProvider provider) : super(ChatInitial()) {
    on<LoadChats>((event, emit) async {
      emit(ChatLoading(isLoading: true));
      try {
        final List<Message> messages = await provider.loadChats(
          chatRoomId: event.chatRoomId,
        );
        emit(ChatLoading(isLoading: false));
        emit(ChatLoaded(messages: messages));
      } catch (e) {
        emit(ChatLoading(
          isLoading: false,
          exception: e as Exception,
        ));
      }
    });

    on<ReceiveChat>((event, emit) {
      Message message = Message(
        description: event.message.message,
        sender: Sender(
          username: event.message.username,
        ),
        created: event.message.created,
      );

      emit(ChatReceived(message: message));
    });

    on<ReceiveStoreChat>((event, emit) {
      emit(ChatReceived(message: event.message));
    });
  }
}
