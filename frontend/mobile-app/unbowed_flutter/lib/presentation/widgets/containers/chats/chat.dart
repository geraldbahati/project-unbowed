import 'package:flutter/material.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/other_chat.dart';

import 'me_chat.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  bool _isMe = false;
  bool _isFirst = false;
  bool _isSame = false;

  @override
  Widget build(BuildContext context) {
    return _isMe ? MeChat() : OtherChat();
  }
}
