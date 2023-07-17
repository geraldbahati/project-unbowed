import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneNumberTextFieldWidget extends StatefulWidget {
  const PhoneNumberTextFieldWidget({Key? key}) : super(key: key);

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
    return Container(
      width: 211,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '+254',
            style: GoogleFonts.leagueSpartan(
              // fontFamily: 'League Spartan',
              color: Color(0xFF69696A),
              fontSize: 18.5,
            ),
          ),
          SizedBox(
            height: 18,
            child: VerticalDivider(
              width: 15,
              thickness: 2,
              color: Color(0xFF69696A),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
              child: TextFormField(
                // controller: _model.textController,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  // labelStyle: FlutterFlowTheme.of(context).labelMedium,
                  hintText: 'Phone number',
                  hintStyle: GoogleFonts.leagueSpartan(
                    // fontFamily: 'League Spartan',
                    fontSize: 18.5,
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
                  fontSize: 18.5,
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
