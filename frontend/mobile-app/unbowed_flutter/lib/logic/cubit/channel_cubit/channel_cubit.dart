import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    _provider.connect(chatRoomId: chatRoomId).then((channel) {
      emit(ChannelConnected(channel: channel));
      emit(ChannelConnecting(isConnecting: true));
      //stream subscription
      channel.stream.listen((jsonResponse) {
        emit(ChatReceived(
          message: msReceiveFromJson(jsonResponse),
        ));
      });
    }).catchError((e) {
      emit(ChannelConnecting(
        exception: e,
        isConnecting: false,
      ));
    });
  }
}
