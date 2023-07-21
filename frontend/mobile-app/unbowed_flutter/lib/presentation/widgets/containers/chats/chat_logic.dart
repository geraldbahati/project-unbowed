// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unbowed_flutter/data/models/messages/message_model.dart';
import 'package:unbowed_flutter/logic/bloc/auth_bloc/auth_bloc.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/me_chat.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/other_chat.dart';

class ChatLogic extends StatefulWidget {
  final Message message;

  const ChatLogic({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<ChatLogic> createState() => _ChatLogicState();
}

class _ChatLogicState extends State<ChatLogic> {
  late final Message _messageObject;
  bool _isMe = false;

  @override
  void initState() {
    super.initState();

    _messageObject = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistered) {
            _isMe = state.user.user.username.toLowerCase() ==
                _messageObject.sender!.username!.toLowerCase();
          }
        },
        child: _isMe
            ? MeChat(
                message: _messageObject,
              )
            : OtherChat(
                message: _messageObject,
              ));
  }
}
