import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:web_socket_channel/io.dart';

import '../../../data/models/messages/message_model.dart';
import '../../../data/models/messages/message_receive.dart';
import '../../../data/provider/chat_provider.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(ChatProvider provider) : super(ChatInitial()) {
    on<ConnectSocket>((event, emit) {
      emit(SocketConnecting(isConnecting: false));
      provider.connect(chatRoomId: event.chatRoomId).then((channel) {
        emit(SocketConnected(channel: channel));
        emit(SocketConnecting(isConnecting: true));
        //stream subscription
        channel.stream.listen((jsonResponse) {
          emit(ChatReceived(
            message: msReceiveFromJson(jsonResponse),
          ));
        });
      }).catchError((e) {
        emit(SocketConnecting(
          exception: e,
          isConnecting: false,
        ));
      });
    });
  }
}
