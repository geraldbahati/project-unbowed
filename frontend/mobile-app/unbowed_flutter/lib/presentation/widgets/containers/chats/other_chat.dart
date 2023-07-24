import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/data/models/messages/message_model.dart';
import 'package:unbowed_flutter/presentation/widgets/containers/chats/custom_chat_container.dart';

class OtherChat extends StatefulWidget {
  final Message message;
  final bool isSamePerson;

  const OtherChat({
    Key? key,
    required this.message,
    this.isSamePerson = false,
  }) : super(key: key);

  @override
  State<OtherChat> createState() => _OtherChatState();
}

class _OtherChatState extends State<OtherChat> {
  late bool _showTime;

  @override
  void initState() {
    super.initState();

    _showTime = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const AlignmentDirectional(-1, 1),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 9.89.w, bottom: 0.5.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: !(widget.message.isFirst ||
                        widget.message.isMiddle ||
                        widget.message.isLast) ||
                    widget.message.isFirst,
                child: _buildSenderName(),
              ),
              _buildMessageBubble(context),
              _buildMessageTimestamp(),
            ],
          ),
        ),
        Visibility(
          visible: widget.message.isLast ||
              !(widget.message.isFirst ||
                  widget.message.isMiddle ||
                  widget.message.isLast),
          child: Padding(
            padding: EdgeInsets.only(top: 0.43.h),
            child: _buildProfileImage(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSenderName() {
    return Padding(
      padding: EdgeInsets.only(left: 2.64.w, bottom: 0.43.h, top: 1.73.h),
      child: Text(
        widget.message.sender!.username!,
        style: GoogleFonts.leagueSpartan(
            fontWeight: FontWeight.w600,
            // fontSize: 16,
            fontSize: 13.33.sp),
      ),
    );
  }

  Widget _buildMessageBubble(context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: _showTime
              ? 0.22.h
              : widget.message.isFirst || widget.message.isMiddle
                  ? 0
                  : 1.83.h),
      child: GestureDetector(
          onTap: () {
            setState(() {
              _showTime = !_showTime;
            });
          },
          child: widget.message.isLast ||
                  !(widget.message.isFirst ||
                      widget.message.isMiddle ||
                      widget.message.isLast)
              ? ChatBubble(
                  message: widget.message.description!,
                )
              : Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.orange,
                    color: Colors.white.withOpacity(0.42),
                    borderRadius: BorderRadius.circular(13.33.sp),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(2.64.w, 1.51.h, 2.64.w, 0.97.h),
                    child: Text(
                      widget.message.description!,
                      // "I am better",
                      textAlign: TextAlign.start,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 15.sp,
                      ),
                      // style: chatRoomTitleTextStyle,
                    ),
                  ),
                )),
    );
  }

  Widget _buildMessageTimestamp() {
    return Padding(
      padding: EdgeInsets.fromLTRB(3.30.w, 0.32.h, 2.86.w, 0),
      child: Visibility(
        visible: _showTime,
        child: Text(
          '${DateFormat.LLLL().format(widget.message.created!)} ${DateFormat.jm().format(widget.message.created!)}',
          textAlign: TextAlign.start,
          maxLines: 1,
          style: GoogleFonts.leagueSpartan(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(context) {
    return Container(
      width: 13.19.w,
      height: 6.47.h,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     Color.fromRGBO(211, 233, 244, 0.96),
        //     Color.fromRGBO(233, 209, 241, 0.93),
        //   ],
        // ),
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Container(
          width: 9.01.w,

          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          // child: CachedNetworkImage(
          //   imageUrl: 'https://picsum.photos/seed/323/600',
          //   fit: BoxFit.cover,
          // ),
          child: Image.network(
            'https://picsum.photos/seed/377/600',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
