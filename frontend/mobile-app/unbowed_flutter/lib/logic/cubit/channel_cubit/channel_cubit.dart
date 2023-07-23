import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unbowed_flutter/data/models/messages/online_users_response.dart';
import 'package:unbowed_flutter/data/provider/chat_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../../data/models/messages/message_receive.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<ChannelState> {
  late final IOWebSocketChannel _channel;
  late final ChatProvider _provider;

  ChannelCubit(ChatProvider provider) : super(ChannelInitial()) {
    _provider = provider;
  }

  @override
  Future<void> close() {
    _channel.sink.close(status.goingAway);
    return super.close();
  }

  void connect({
    required String chatRoomId,
  }) async {
    emit(ChannelConnecting(isConnecting: false));

    try {
      _channel = await _provider.connect(chatRoomId: chatRoomId);
      emit(ChannelConnected(channel: _channel));
      emit(ChannelConnecting(isConnecting: true));
      //stream subscription
      _channel.stream.listen((jsonResponse) {
        final data = jsonDecode(jsonResponse);
        final action = data['action'];

        if (action == 'typing') {
          emit(TypingState(
            isTyping: true,
            username: data['username'],
          ));
        } else if (action == 'receive-message') {
          print(msReceiveFromJson(jsonResponse).message);
          emit(MessageReceived(
            message: msReceiveFromJson(jsonResponse),
          ));
        } else if (action == 'online_users') {
          emit(
            OnlineUsers(
              onlineStatus: onlineUsersResponseFromJson(jsonResponse),
            ),
          );
        }
      });
    } on Exception catch (e) {
      emit(ChannelConnecting(
        exception: e,
        isConnecting: false,
      ));
    }
  }
}
