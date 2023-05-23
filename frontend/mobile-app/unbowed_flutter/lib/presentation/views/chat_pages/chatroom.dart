import 'package:flutter/material.dart';

import '../../widgets/containers/chat_container.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          ChatContainer(),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
