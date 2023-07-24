import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/router/route_mapping.dart';

import '../../../logic/bloc/auth_bloc/auth_bloc.dart';
import '../../widgets/buttons/otp_button.dart';
import '../../widgets/textfields/otp_number_field.dart';

class OtpPageWidget extends StatefulWidget {
  const OtpPageWidget({Key? key}) : super(key: key);

  @override
  _OtpPageWidgetState createState() => _OtpPageWidgetState();
}

class _OtpPageWidgetState extends State<OtpPageWidget> {
  final FocusNode _unfocusNode = FocusNode();
  late final List<FocusNode> _otpFocusNode;
  late final List<TextEditingController> _otpTextController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final int _otpLength = 6;
  int _currentOtpField = 0;

  @override
  void initState() {
    super.initState();

    _otpFocusNode = List.generate(_otpLength, (index) => FocusNode());
    _otpTextController = List.generate(
      _otpLength,
      (index) => TextEditingController(),
    );

    _otpFocusNode[_currentOtpField].requestFocus();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();

    for (int i = 0; i < _otpLength; i++) {
      _otpFocusNode[i].dispose();
      _otpTextController[i].dispose();
    }

    super.dispose();
  }

  void _onOtpInputChange(String value) {
    _otpTextController[_currentOtpField].text = value;

    if (value.isNotEmpty) {
      if (_currentOtpField < _otpLength - 1) {
        setState(() {
          _currentOtpField++;
        });
        _otpFocusNode[_currentOtpField].requestFocus();
      } else {
        _otpFocusNode[_currentOtpField].unfocus();
      }
    } else if (value.isEmpty) {
      if (_currentOtpField > 0) {
        setState(() {
          _currentOtpField--;
        });
        _otpFocusNode[_currentOtpField].requestFocus();
      }
    }
  }

  void _submitOtp() {
    String otp = '';
    for (var controller in _otpTextController) {
      otp += controller.text;
    }

    String phoneNumber, secretKey;

    if (context.read<AuthBloc>().state is AuthPhoneNumberSent) {
      phoneNumber =
          (context.read<AuthBloc>().state as AuthPhoneNumberSent).phoneNumber;
      secretKey =
          (context.read<AuthBloc>().state as AuthPhoneNumberSent).secretKey;
    } else {
      print("Ukona error hapa");
      return;
    }
    // String phoneNumber = context.read<AuthBloc>().state.phoneNumber;
    // String secretKey = context.read<AuthBloc>().state.secretKey;

    print(secretKey);
    context.read<AuthBloc>().add(
          VerifyOtpEvent(
            phoneNumber: phoneNumber,
            secretKey: secretKey,
            verificationCode: otp,
          ),
        );
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
                if (state is AuthRegistered) {
                  Navigator.pushNamed(context, homeRoute);
                } else if (state is AuthRegistering) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("the error is ${state.exception}"),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Enter OTP',
                        style: GoogleFonts.alata(
                          // fontFamily: 'Alata',
                          color: Color(0xFF1B5AD4),
                          fontSize: 26.sp,
                        ),
                      ),
                      SizedBox(
                        height: 6.953.h,
                      ),
                      Text(
                        'We have send you access code via SMS for Mobile Verification',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.leagueSpartan(
                          // fontFamily: 'League Spartan',
                          fontSize: 19.sp,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(
                        height: 3.107.h,
                      ),

                      // OTP Number Fields
                      SizedBox(
                        height: 6.36.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 3.75.w,
                          ),
                          itemCount: _otpLength,
                          itemBuilder: (context, index) {
                            return Center(
                                child: OTPNumberFieldWidget(
                              focusNode: _otpFocusNode[index],
                              textController: _otpTextController[index],
                              onChanged: _onOtpInputChange,
                            ));
                          },
                        ),
                      ),

                      SizedBox(
                        height: 6.657.h,
                      ),

                      // OTP Button
                      OTPCustomButtonWidget(
                        text: "verify",
                        onPressed: () {
                          // print('Verify button pressed');
                          _submitOtp();
                        },
                      ),

                      SizedBox(
                        height: 5.769.h,
                      ),
                      Text(
                        'Didn’t Receive the OTP?',
                        style: GoogleFonts.leagueSpartan(
                          // fontFamily: 'League Spartan',
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        width: 31.25.w,
                        height: 4.438.h,
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Resend code',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.leagueSpartan(
                              // fontFamily: 'League Spartan',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.769.h,
                      ),
                    ],
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
