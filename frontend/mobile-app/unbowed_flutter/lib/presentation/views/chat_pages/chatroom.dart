import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/chat_logic.dart';

import '../../widgets/containers/chatroom_appbar.dart';
import '../../widgets/containers/chats/me_chat.dart';
import '../../widgets/containers/chats/other_chat.dart';
import '../../widgets/textfields/chat_textfield.dart';

class ChatroomPageWidget extends StatefulWidget {
  const ChatroomPageWidget({Key? key}) : super(key: key);

  @override
  _ChatroomPageWidgetState createState() => _ChatroomPageWidgetState();
}

class _ChatroomPageWidgetState extends State<ChatroomPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  UniqueKey? _uniqueKey;
  List<ChatLogic> _chatList = [];

  late final AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  void _getAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
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

          // Header Sliver Builder

          body: Builder(
            builder: (context) {
              return SafeArea(
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
                        child: SizedBox(
                          width: double.infinity,
                          height: 86.h,
                          child: ListView(
                            controller: _scrollController,
                            // reverse: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            children: [
                              OtherChat(
                                message:
                                    'No problem! To hide the sidebar in Figma, you can follow these steps:',
                              ),
                              MeChat(
                                isFirst: true,
                              ),
                              MeChat(),
                              OtherChat(
                                message: "Gerald is the best",
                              ),
                              MeChat(
                                isFirst: true,
                              ),
                              OtherChat(
                                message: "K 😍",
                              ),
                              MeChat(
                                isFirst: true,
                              ),
                              MeChat(),
                              OtherChat(
                                message: "Gerald is the best",
                              ),
                              MeChat(
                                isFirst: true,
                              ),
                              MeChat(),
                              OtherChat(
                                message: "Gerald is the best",
                              ),
                              MeChat(
                                isFirst: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: ChatTextfield(),
                    ),
                    ChatroomAppBarWidget(
                      callback: _getAnimationController,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
