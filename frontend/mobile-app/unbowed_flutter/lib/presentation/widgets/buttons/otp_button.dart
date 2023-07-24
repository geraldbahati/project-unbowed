// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class OTPCustomButtonWidget extends StatefulWidget {
  final String text;
  final void Function()? onPressed;

  const OTPCustomButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  _OTPCustomButtonWidgetState createState() => _OTPCustomButtonWidgetState();
}

class _OTPCustomButtonWidgetState extends State<OTPCustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 84.375.w,
        height: 6.805.h,
        decoration: BoxDecoration(
          color: Color(0xFF1B5AD4),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            widget.text.toUpperCase(),
            style: GoogleFonts.leagueSpartan(
              // fontFamily: 'League Spartan',
              color: Colors.white,
              fontSize: 22.sp,
            ),
          ),
        ),
      ),
    );
  }
}
