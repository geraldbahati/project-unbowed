import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/router/route_mapping.dart';
import 'package:unbowed_flutter/presentation/styles/theme.dart';

import '../../styles/text_styling.dart';

class ChatroomTile extends StatelessWidget {
  const ChatroomTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 2.58.h, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 13.95.w,
                height: 13.95.w,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/377/600',
                  fit: BoxFit.cover,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, chatRoomRoute);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.33.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0.43.h),
                        child: Text(
                          'The Rocks',
                          style: chatRoomTitleTextStyle,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0.43.h, 0, 0),
                        child: Text(
                          "Gerald Bahati started a party",
                          style: chatRoomSubTitleTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1.40.w, 0.43.h),
                child: Container(
                  width: 2.33.w,
                  height: 2.33.w,
                  decoration: const BoxDecoration(
                    color: lightBlue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0.43.h, 0, 0),
                child: Text(
                  "Yesterday",
                  style: chatRoomTimeTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
