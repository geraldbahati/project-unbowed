// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class OTPNumberFieldWidget extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textController;
  final void Function(String value) onChanged;

  const OTPNumberFieldWidget({
    Key? key,
    required this.focusNode,
    required this.textController,
    required this.onChanged,
  }) : super(key: key);

  @override
  _OTPNumberFieldWidgetState createState() => _OTPNumberFieldWidgetState();
}

class _OTPNumberFieldWidgetState extends State<OTPNumberFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.w,
      height: 5.62.h,
      decoration: BoxDecoration(
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(2),
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: TextFormField(
          controller: widget.textController,
          focusNode: widget.focusNode,
          // maxLength: 1,
          obscureText: false,
          decoration: InputDecoration(
            // labelStyle: FlutterFlowTheme.of(context).labelMedium,
            hintText: '0',
            hintStyle: GoogleFonts.leagueSpartan(
              // fontFamily: 'League Spartan',
              fontSize: 18.sp,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          style: GoogleFonts.leagueSpartan(
            // fontFamily: 'League Spartan',
            fontSize: 18.sp,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onChanged: (value) => widget.onChanged(value),
          // validator: _model.textControllerValidator.asValidator(context),
        ),
      ),
    );
  }
}
