import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/buttons/otp_button.dart';
import '../../widgets/textfields/phone_number_input.dart';

class PhoneAuthPageWidget extends StatefulWidget {
  const PhoneAuthPageWidget({Key? key}) : super(key: key);

  @override
  _PhoneAuthPageWidgetState createState() => _PhoneAuthPageWidgetState();
}

class _PhoneAuthPageWidgetState extends State<PhoneAuthPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _unFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unFocusNode),
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/smartphone.png',
                        width: 122,
                        height: 122,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 43,
                    ),
                    Text(
                      'Verify your Number',
                      style: GoogleFonts.alata(
                        // fontFamily: 'Alata',
                        color: Color(0xFF1B5AD4),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 47,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Text(
                        'please enter your mobile number to receive verification code',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.leagueSpartan(
                          // fontFamily: 'League Spartan',
                          fontSize: 18.5,
                          // lineHeight: 1.5,
                          height: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 47,
                    ),
                    PhoneNumberTextFieldWidget(),
                    SizedBox(
                      height: 41,
                    ),
                    OTPCustomButtonWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
