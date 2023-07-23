import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unbowed_flutter/data/models/messages/message_model.dart';
import 'package:unbowed_flutter/logic/bloc/auth_bloc/auth_bloc.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/me_chat.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/other_chat.dart';

class ChatLogic extends StatefulWidget {
  final Message message;
  final bool isSamePerson;

  const ChatLogic({
    Key? key,
    required this.message,
    this.isSamePerson = false,
  }) : super(key: key);

  @override
  State<ChatLogic> createState() => ChatLogicState();
}

class ChatLogicState extends State<ChatLogic> {
  late final Message _messageObject;
  bool _isMe = false;

  @override
  void initState() {
    super.initState();

    _messageObject = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthRegistered) {
          _isMe = state.user.user.username == _messageObject.sender!.username;
          print(_isMe);
        }

        return _isMe
            ? MeChat(
                message: _messageObject,
                isSamePerson: widget.isSamePerson,
              )
            : OtherChat(
                message: _messageObject,
                isSamePerson: widget.isSamePerson,
              );
      },
    );
  }
}
