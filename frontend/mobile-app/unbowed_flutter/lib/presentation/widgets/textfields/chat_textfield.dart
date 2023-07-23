// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ChatTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onTyping;
  final void Function()? onSend;
  const ChatTextfield({
    Key? key,
    required this.controller,
    required this.onTyping,
    this.onSend,
  }) : super(key: key);

  @override
  State<ChatTextfield> createState() => _ChatTextfieldState();
}

class _ChatTextfieldState extends State<ChatTextfield> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  void _onTextFieldFocusChanged() {
    setState(() {
      _isFocused = !_focusNode.hasFocus;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusNode.addListener(_onTextFieldFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onTextFieldFocusChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.background,
          color: Colors.white.withOpacity(0.42),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(2.20.w, 1.73.h, 0, 1.29.h),
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.end,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () => _onToggleButtonPressed(),
                        child: Container(
                          width: 10.99.w,
                          height: 5.39.h,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            !_focusNode.hasFocus
                                ? Icons.chevron_left_outlined
                                : Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 19.95.sp,
                          ),
                        ),
                      ),
                      _isFocused
                          ? Wrap(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3.97.w, 0, 0, 0),
                                    child: Transform.rotate(
                                      angle: -0.3491,
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        child: Icon(
                                          Icons.tag_faces,
                                          color: Colors.grey,
                                          size: 19.95.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.22.w, 0, 0, 0),
                                    child: Icon(
                                      Icons.broken_image_outlined,
                                      color: Colors.grey,
                                      size: 19.95.sp,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: () => _onAddButtonPressed(),
                              child: Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      3.97.w, 0, 0, 0),
                                  child: Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                      size: 19.95.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      4.10.w,
                      1.29.h,
                      3.74.w,
                      1.08.h,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color(0x3257636C),
                        // color: Colors.white.withOpacity(0.82),
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(24.9375.sp),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                2.64.w,
                                0,
                                1.76.w,
                                // 0.54.h,
                                0,
                              ),
                              child: TextFormField(
                                focusNode: _focusNode,
                                controller: widget.controller,
                                onChanged: (value) => widget.onTyping(value),
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.multiline,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: GoogleFonts.leagueSpartan(
                                    fontSize: 15.sp,
                                  ),
                                  hintText: 'Aa',
                                  hintStyle: GoogleFonts.leagueSpartan(
                                    color: Colors.white70,
                                    fontSize: 15.sp,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                ),
                                maxLines: 7,
                                minLines: 1,
                                // validator: _model.textControllerValidator
                                //     .asValidator(context),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 4.62.w, 1.73.h),
                            child: GestureDetector(
                              onTap: _focusNode.hasFocus ? widget.onSend : null,
                              child: Icon(
                                _focusNode.hasFocus
                                    ? Icons.send
                                    : Icons.mic_outlined,
                                color: Colors.white70,
                                size: 19.95.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // add button function
  void _onAddButtonPressed() {
    setState(() {
      _isFocused = true;
    });
  }

  void _onToggleButtonPressed() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      Navigator.of(context).pop();
    }
  }
}
