// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/logic/cubit/channel_cubit/channel_cubit.dart';

class ChatroomAppBarWidget extends StatefulWidget {
  final Function(AnimationController) callback;

  const ChatroomAppBarWidget({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  _ChatroomAppBarWidgetState createState() => _ChatroomAppBarWidgetState();
}

class _ChatroomAppBarWidgetState extends State<ChatroomAppBarWidget>
    with SingleTickerProviderStateMixin {
  // animation controllers
  late final AnimationController _resizeAnimationController;

  // animation variables
  // --- resize appbar
  late final Animation<double> _resizeAppbarAnimation;
  late final Animation<double> _resizeProfilePhotoAnimation;
  late final Animation<double> _resizeProfilePhotoBorderWidthAnimation;
  late final Animation<double> _resizeProfilePhotoBorderHeightAnimation;
  late final Animation<double> _resizespaceBetweenIconsAnimation;
  late final Animation<double> _bounceInAnimation;

  @override
  void initState() {
    super.initState();

    _resizeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    widget.callback(_resizeAnimationController);

    // resize appbar
    _resizeAppbarAnimation = Tween<double>(
      begin: 20.60.h,
      end: 9.29.h,
    ).animate(
      CurvedAnimation(
        parent: _resizeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // resize profile photo
    _resizeProfilePhotoAnimation = Tween<double>(
      begin: 19.78.w,
      end: 9.01.w,
    ).animate(
      CurvedAnimation(
        parent: _resizeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // resize profile photo border
    _resizeProfilePhotoBorderWidthAnimation = Tween<double>(
      begin: 16.48.w,
      end: 9.23.w,
    ).animate(
      CurvedAnimation(
        parent: _resizeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _resizeProfilePhotoBorderHeightAnimation = Tween<double>(
      begin: 8.09.h,
      end: 4.53.h,
    ).animate(
      CurvedAnimation(
        parent: _resizeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // space between icons
    _resizespaceBetweenIconsAnimation = Tween<double>(
      begin: 10.01.w,
      end: 6.71.w,
    ).animate(
      CurvedAnimation(
        parent: _resizeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // opacity
    _bounceInAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_resizeAnimationController);

    // slide in
  }

  @override
  void dispose() {
    _resizeAnimationController.dispose();
    _resizeAppbarAnimation.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: AnimatedBuilder(
        animation: _resizeAnimationController,
        builder: (context, child) => Container(
          width: double.infinity,
          height: _resizeAppbarAnimation.value,
          decoration: const BoxDecoration(
            color: Colors.white70,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                7.69.w,
                2.05.h,
                8.62.w,
                // 2.70.h,
                0,
              ),
              child: BlocBuilder<ChannelCubit, ChannelState>(
                builder: (context, state) {
                  return Stack(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            spacing: 0,
                            runSpacing: 0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              Stack(
                                alignment: const AlignmentDirectional(0, 0),
                                children: [
                                  Container(
                                    width: _resizeProfilePhotoAnimation.value,
                                    // height: 9.71.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: Image.network(
                                      'https://picsum.photos/seed/186/600',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        _resizeProfilePhotoBorderWidthAnimation
                                            .value,
                                    height:
                                        _resizeProfilePhotoBorderHeightAnimation
                                            .value,
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(1, 1),
                                      child: Container(
                                        width: 2.64.w,
                                        height: 1.29.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Align(
                                          alignment:
                                              const AlignmentDirectional(0, 0),
                                          child: Container(
                                            width: 1.76.w,
                                            height: 0.86.h,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 0.88.w,
                              ),
                              Opacity(
                                opacity: _bounceInAnimation.value,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 38.46.w,
                                  ),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "The Rocks",
                                          style: GoogleFonts.averageSans(
                                            fontSize: 15.sp,
                                          ),
                                        ),

                                        // status text
                                        Text(
                                          state is TypingState
                                              ? '${state.username} is typing...'
                                              : 'Kylon_thagoat7 and 3 other members online',
                                          style: GoogleFonts.averageSans(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 11.6375.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 0,
                            runSpacing: 0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.end,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                Icons.person_add_alt_1_sharp,
                                color: Colors.black,
                                size: 23.275.sp,
                              ),
                              SizedBox(
                                width: _resizespaceBetweenIconsAnimation.value,
                              ),
                              Icon(
                                Icons.info_rounded,
                                color: Colors.black,
                                size: 19.95.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(height: 0.54.h),
                      Visibility(
                        visible: _resizeAnimationController.value < 0.6,
                        child: Align(
                          alignment: AlignmentDirectional(-1, 0.5),
                          child: Opacity(
                            opacity: 1 - (_bounceInAnimation.value),
                            child: Wrap(
                              spacing: 0,
                              runSpacing: 0,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.vertical,
                              runAlignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              clipBehavior: Clip.none,
                              children: [
                                Text(
                                  'The Rock',
                                  style: GoogleFonts.averageSans(
                                    fontSize: 20.37.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  state is TypingState
                                      ? '${state.username} is typing...'
                                      : 'Kylon_thagoat7 and 3 other members online',
                                  style: GoogleFonts.averageSans(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 13.13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
