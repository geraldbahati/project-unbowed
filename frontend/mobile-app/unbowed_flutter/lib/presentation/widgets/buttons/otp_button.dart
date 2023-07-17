import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPCustomButtonWidget extends StatefulWidget {
  const OTPCustomButtonWidget({Key? key}) : super(key: key);

  @override
  _OTPCustomButtonWidgetState createState() => _OTPCustomButtonWidgetState();
}

class _OTPCustomButtonWidgetState extends State<OTPCustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 46,
      decoration: BoxDecoration(
        color: Color(0xFF1B5AD4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Text(
          'SEND',
          style: GoogleFonts.leagueSpartan(
            // fontFamily: 'League Spartan',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
