import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/logic/bloc/auth_bloc/auth_bloc.dart';
import 'package:unbowed_flutter/presentation/router/route_mapping.dart';

import '../../widgets/buttons/otp_button.dart';
import '../../widgets/textfields/phone_number_input.dart';

class PhoneAuthPageWidget extends StatefulWidget {
  const PhoneAuthPageWidget({Key? key}) : super(key: key);

  @override
  _PhoneAuthPageWidgetState createState() => _PhoneAuthPageWidgetState();
}

class _PhoneAuthPageWidgetState extends State<PhoneAuthPageWidget> {
  late final TextEditingController _phoneNumberController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _unfocusNode.dispose();

    super.dispose();
  }

  String removeFirstCharacter(String inputString) {
    if (inputString.length <= 1) {
      return '';
    }

    return inputString.substring(1);
  }

  void _submitPhoneNumber() {
    var phoneNumber = _phoneNumberController.text.trim();
    FocusScope.of(context).requestFocus(_unfocusNode);
    if (phoneNumber.isNotEmpty &&
        (phoneNumber.length == 9 || phoneNumber.length == 10)) {
      phoneNumber = phoneNumber.length == 9
          ? "+254$phoneNumber"
          : "+254${removeFirstCharacter(phoneNumber)}";

      context
          .read<AuthBloc>()
          .add(SendPhoneNumberEvent(phoneNumber: phoneNumber));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a phone number'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(211, 233, 244, 0.96),
              Color.fromRGBO(233, 209, 241, 0.93),
            ],
          ),
        ),
        child: Scaffold(
          key: scaffoldKey,
          // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          backgroundColor: Colors.white.withOpacity(0.2),
          body: SafeArea(
            top: true,
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
                if (context.read<AuthBloc>().state is AuthPhoneNumberSent) {
                  Navigator.pushNamed(context, confirmOtpRoute);
                } else if (context.read<AuthBloc>().state is AuthRegistering) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "the error is ${context.read<AuthBloc>().state}"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(7.8125.w, 0, 7.8125.w, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/smartphone.png',
                            width: 38.125.w,
                            height: 18.047.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 6.361.h,
                        ),
                        Text(
                          'Verify your Number',
                          style: GoogleFonts.alata(
                            color: Color(0xFF1B5AD4),
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 6.953.h,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            1.5625.w,
                            0,
                            1.5625.w,
                            0,
                          ),
                          child: Text(
                            'please enter your mobile number to receive verification code',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 19.sp,
                              height: 1.5,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.953.h,
                        ),
                        PhoneNumberTextFieldWidget(
                          controller: _phoneNumberController,
                        ),
                        SizedBox(
                          height: 6.065.h,
                        ),
                        OTPCustomButtonWidget(
                          text: 'Send',
                          onPressed: _submitPhoneNumber,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
