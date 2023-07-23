import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/data/models/chatroom/chatroom_model.dart';
import 'package:unbowed_flutter/logic/bloc/chat_bloc/chat_bloc.dart';
import 'package:unbowed_flutter/presentation/styles/text_styling.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chatroom_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final List<ChatroomModel> _chatList = [];

  void _loadChatRoomsFromApi() {
    context.read<ChatBloc>().add(LoadChatRooms());
  }

  @override
  void initState() {
    super.initState();

    _loadChatRoomsFromApi();
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
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.2),
        key: scaffoldKey,
        // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,

        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: SafeArea(
                top: false,
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(7.44.w, 3.22.h, 7.44.w, 0),
                  child: BlocListener<ChatBloc, ChatState>(
                    listener: (context, state) {
                      if (state is ChatRoomsLoaded) {
                        setState(() {
                          _chatList.addAll(state.chatRooms);
                        });
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 2.04.h,
                          ),
                          child: Wrap(
                            spacing: 0,
                            runSpacing: 0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.end,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 3.h, 0, 4.08.h),
                                child: Text(
                                  'Chats',
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      2.33.w,
                                      0,
                                      2.33.w,
                                      0,
                                    ),
                                    child: Icon(
                                      Icons.settings_outlined,
                                      color: Colors.grey,
                                      size: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    'Messages',
                                    style: messageTitleTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 83.69.h,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: _chatList.length,
                            itemBuilder: (context, index) => ChatroomTile(
                              chatroomModel: _chatList[index],
                            ),
                          ),
                          // child: BlocBuilder<ChatBloc, ChatState>(
                          //   builder: (context, state) {
                          //     if (state is ChatRoomsLoaded) {
                          //       return ListView.builder(
                          //         padding: EdgeInsets.zero,
                          //         scrollDirection: Axis.vertical,
                          //         itemCount: state.chatRooms.length,
                          //         itemBuilder: (context, index) => ChatroomTile(
                          //           chatroomModel: state.chatRooms[index],
                          //         ),
                          //       );
                          //     }

                          //     return const Center(
                          //       child: CircularProgressIndicator(),
                          //     );
                          //   },
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
