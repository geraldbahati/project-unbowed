import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
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

  @override
  void initState() {
    super.initState();
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
                          itemCount: 20,
                          itemBuilder: (context, index) => const ChatroomTile(),
                        ),
                      ),
                    ],
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
