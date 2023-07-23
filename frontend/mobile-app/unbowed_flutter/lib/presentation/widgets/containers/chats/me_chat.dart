// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/data/models/messages/message_model.dart';

class MeChat extends StatefulWidget {
  final Message message;
  final bool isSamePerson;
  const MeChat({
    Key? key,
    required this.message,
    this.isSamePerson = false,
  }) : super(key: key);

  @override
  State<MeChat> createState() => _MeChatState();
}

class _MeChatState extends State<MeChat> {
  late bool _showTime;

  @override
  void initState() {
    super.initState();

    _showTime = false;
  }

  @override
  void dispose() {
    super.dispose();

    _showTime = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: const AlignmentDirectional(1, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              0,
              !widget.isSamePerson ? 1.73.h : 0,
              0,
              0.22.h,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showTime = !_showTime;
                });
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(13.33.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2.64.w, 1.51.h, 2.64.w, 0.97.h),
                  child: Text(
                    widget.message.description!,
                    textAlign: TextAlign.start,
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: GoogleFonts.leagueSpartan(
                        fontSize: 15.sp, color: Colors.white),
                    // style: chatRoomTitleTextStyle,
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: _showTime,
          child: Padding(
            padding: EdgeInsets.fromLTRB(3.30.w, 0.32.h, 2.86.w, 0.32.h),
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
        ),
      ],
    );
  }
}
