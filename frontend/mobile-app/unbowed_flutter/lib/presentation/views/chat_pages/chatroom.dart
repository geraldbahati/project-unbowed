import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/me_chat.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/other_chat.dart';
import 'package:unbowed_flutter/presentation/widgets/textfields/chat_textfiled.dart';

class ChatroomPageWidget extends StatefulWidget {
  const ChatroomPageWidget({Key? key}) : super(key: key);

  @override
  _ChatroomPageWidgetState createState() => _ChatroomPageWidgetState();
}

class _ChatroomPageWidgetState extends State<ChatroomPageWidget> {
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
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [const ChatAppBar()],
          body: Builder(
            builder: (context) {
              return SafeArea(
                top: false,
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(6.59.w, 0, 7.69.w, 0),
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            OtherChat(),
                            MeChat(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: ChatTextfield(),
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

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 19.63.h,
      collapsedHeight: 9.39.h,
      pinned: true,
      floating: false,
      backgroundColor: Colors.grey,
      automaticallyImplyLeading: false,
      leading: Align(
        alignment: const AlignmentDirectional(1, 0),
        child: SizedBox(
          width: 43,
          height: 4.53.h,
          child: Stack(
            alignment: AlignmentDirectional(1, 0),
            children: [
              Container(
                width: 41,
                height: 41,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/seed/887/600',
                  fit: BoxFit.cover,
                ),
                // child: Image.network(
                //   'https://picsum.photos/seed/377/600',
                //   fit: BoxFit.cover,
                // ),
              ),
              Align(
                alignment: const AlignmentDirectional(1, 1),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      title: Align(
        alignment: AlignmentDirectional(-1, 0),
        child: Text(
          'The Rocks',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 30.54, 0),
          child: Icon(
            Icons.person_add,
            color: Colors.black,
            size: 24,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 29.2, 0),
          child: Icon(
            Icons.info_sharp,
            color: Colors.black,
            size: 24,
          ),
        ),
      ],
      centerTitle: false,
      elevation: 2,
    );
  }
}
