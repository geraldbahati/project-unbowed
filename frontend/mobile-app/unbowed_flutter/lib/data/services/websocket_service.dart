import 'package:unbowed_flutter/data/config/config.dart';
import 'package:unbowed_flutter/data/services/shared_services.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketService<T> {
  final String url;
  final dynamic body;
  T Function(IOWebSocketChannel channel) parse;

  WebsocketService({
    required this.url,
    this.body,
    required this.parse,
  });
}

class Websocket {
  Future<T> connect<T>(WebsocketService<T> service) async {
    var loginDetails = await SharedService().getLoginDetails();

    Map<String, dynamic> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${loginDetails?.tokens.access}",
    };

    Uri url = Uri.parse(
        "ws://${Config.domain}${Config.chatRoomWebSocketUrl}${service.url}/");

    IOWebSocketChannel channel = IOWebSocketChannel.connect(
      url,
      headers: requestHeaders,
    );

    return service.parse(channel);
  }
}
