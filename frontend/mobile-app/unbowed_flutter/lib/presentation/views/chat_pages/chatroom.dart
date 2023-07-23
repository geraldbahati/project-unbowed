import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/logic/bloc/chat_bloc/chat_bloc.dart';
import 'package:unbowed_flutter/logic/cubit/channel_cubit/channel_cubit.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/chat_logic.dart';
import 'package:web_socket_channel/io.dart';

import '../../../data/models/messages/message_request_model.dart';
import '../../../logic/bloc/auth_bloc/auth_bloc.dart';
import '../../widgets/containers/chatroom_appbar.dart';
import '../../widgets/textfields/chat_textfield.dart';

class ChatroomPageWidget extends StatefulWidget {
  final String chatRoomId;
  const ChatroomPageWidget({
    Key? key,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  _ChatroomPageWidgetState createState() => _ChatroomPageWidgetState();
}

class _ChatroomPageWidgetState extends State<ChatroomPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  UniqueKey? _uniqueKey;
  late final IOWebSocketChannel _channel;
  late final TextEditingController _textEditingController;

  final List<ChatLogic> _chatList = [];

  late final AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  void _getAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  void _loadAndSetupChannel() {
    context.read<AuthBloc>().add(AuthEventInitial());
    context.read<ChatBloc>().add(LoadChats(chatRoomId: widget.chatRoomId));
    context.read<ChannelCubit>().connect(chatRoomId: widget.chatRoomId);
  }

  void _onSend() {
    if (_textEditingController.text.isNotEmpty) {
      // Message message = Message(
      //   description: _textEditingController.text,
      //   sender: Sender(
      //     username: 'Gerald',
      //   ),
      //   created: DateTime.now(),
      // );

      // ChatLogic chat = ChatLogic(
      //   message: message,
      //   isSamePerson: true,
      // );

      // _chatList.add(chat);

      _channel.sink.add(messageRequestToJson(MessageRequest(
        action: 'send-message',
        message: _textEditingController.text,
      )));

      _textEditingController.clear();
    }
  }

  void _indicateTyping(String text) {
    if (text.isNotEmpty) {
      _channel.sink.add(messageRequestToJson(MessageRequest(
        action: 'typing',
        message: text,
      )));
    }
  }

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0) {
        _animationController.forward();
      }
    });

    _loadAndSetupChannel();
  }

  @override
  void dispose() {
    _channel.sink.close();
    _textEditingController.dispose();
    _scrollController.dispose();
    // _animationController.dispose();
    _uniqueKey = null;

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(211, 233, 244, 0.96),
              Color.fromRGBO(233, 209, 241, 0.93),
            ],
          ),
        ),
        child: Scaffold(
          key: scaffoldKey,
          // backgroundColor: Theme.of(context).colorScheme.background,
          backgroundColor: Colors.white.withOpacity(0.2),

          // backgroundColor: Colors.transparent,

          body: Builder(
            builder: (context) {
              return SafeArea(
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<ChatBloc, ChatState>(
                      listener: (context, state) {
                        if (state is ChatReceived) {
                          _chatList.add(state.chat);

                          if (state.shouldRefresh) {
                            _uniqueKey = UniqueKey();
                          }

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            );
                          });
                        }
                      },
                    ),
                    BlocListener<ChannelCubit, ChannelState>(
                      listener: (context, state) {
                        if (state is ChannelConnected) {
                          _channel = state.channel;
                        }

                        if (state is MessageReceived) {
                          context
                              .read<ChatBloc>()
                              .add(ReceiveChat(message: state.message));
                        }
                      },
                    ),
                  ],
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 1),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            6.59.w,
                            0,
                            7.69.w,
                            0,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10.0.h),
                            width: double.infinity,
                            height: 86.h,
                            child: BlocBuilder<ChatBloc, ChatState>(
                              builder: (context, state) {
                                return ListView.builder(
                                  // reverse: true,
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  shrinkWrap: true,
                                  key: _uniqueKey,
                                  controller: _scrollController,
                                  itemCount: _chatList.length,
                                  itemBuilder: (context, index) {
                                    return _chatList[index];
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 1),
                        child: ChatTextfield(
                          controller: _textEditingController,
                          onTyping: (text) {
                            _indicateTyping(text);
                          },
                          onSend: _onSend,
                        ),
                      ),
                      ChatroomAppBarWidget(
                        callback: _getAnimationController,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
