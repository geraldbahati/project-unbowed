// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class PhoneNumberTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  const PhoneNumberTextFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PhoneNumberTextFieldWidgetState createState() =>
      _PhoneNumberTextFieldWidgetState();
}

class _PhoneNumberTextFieldWidgetState
    extends State<PhoneNumberTextFieldWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65.9375.w,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '+254',
            style: GoogleFonts.leagueSpartan(
              color: Color(0xFF69696A),
              fontSize: 19.sp,
            ),
          ),
          SizedBox(
            height: 2.663.h,
            child: VerticalDivider(
              width: 4.6875.w,
              thickness: 2,
              color: Color(0xFF69696A),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
              child: TextFormField(
                controller: widget.controller,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  // labelStyle: FlutterFlowTheme.of(context).labelMedium,
                  hintText: 'Phone number',
                  hintStyle: GoogleFonts.leagueSpartan(
                    // fontFamily: 'League Spartan',
                    fontSize: 18.sp,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF69696A),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: GoogleFonts.leagueSpartan(
                  // fontFamily: 'League Spartan',
                  fontSize: 19.sp,
                ),
                keyboardType: TextInputType.phone,

                // validator: _model.textControllerValidator.asValidator(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
