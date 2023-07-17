import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPNumberFieldWidget extends StatefulWidget {
  const OTPNumberFieldWidget({Key? key}) : super(key: key);

  @override
  _OTPNumberFieldWidgetState createState() => _OTPNumberFieldWidgetState();
}

class _OTPNumberFieldWidgetState extends State<OTPNumberFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 43,
      decoration: BoxDecoration(
        color: Colors.white,
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
          // controller: _model.textController,
          obscureText: false,
          decoration: InputDecoration(
            // labelStyle: FlutterFlowTheme.of(context).labelMedium,
            hintText: '0',
            hintStyle: GoogleFonts.leagueSpartan(
              // fontFamily: 'League Spartan',
              fontSize: 19.5,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          style: GoogleFonts.leagueSpartan(
            // fontFamily: 'League Spartan',
            fontSize: 19.5,
          ),
          textAlign: TextAlign.center,
          // validator: _model.textControllerValidator.asValidator(context),
        ),
      ),
    );
  }
}
