import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/buttons/otp_button.dart';
import '../../widgets/textfields/otp_number_field.dart';

class OtpPageWidget extends StatefulWidget {
  const OtpPageWidget({Key? key}) : super(key: key);

  @override
  _OtpPageWidgetState createState() => _OtpPageWidgetState();
}

class _OtpPageWidgetState extends State<OtpPageWidget> {
  final FocusNode _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Enter OTP',
                    style: GoogleFonts.alata(
                      // fontFamily: 'Alata',
                      color: Color(0xFF1B5AD4),
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 47,
                  ),
                  Text(
                    'We have send you access code via SMS for Mobile Verification',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.leagueSpartan(
                      // fontFamily: 'League Spartan',
                      fontSize: 18.5,
                    ),
                  ),
                  SizedBox(
                    height: 21,
                  ),

                  // OTP Number Fields
                  ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 17,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return OTPNumberFieldWidget();
                    },
                  ),

                  SizedBox(
                    height: 45,
                  ),

                  // OTP Button
                  OTPCustomButtonWidget(),

                  SizedBox(
                    height: 39,
                  ),
                  Text(
                    'Didn’t Receive the OTP?',
                    style: GoogleFonts.leagueSpartan(
                      // fontFamily: 'League Spartan',
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'Resend code',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.leagueSpartan(
                          // fontFamily: 'League Spartan',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 39,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
