import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeChat extends StatelessWidget {
  const MeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: AlignmentDirectional(1, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 2),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 11, 9),
                child: Text(
                  'No prob',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 3, 13, 2),
          child: Text(
            'Sunday, 4.01 AM',
            textAlign: TextAlign.start,
            maxLines: 1,
            style: GoogleFonts.inter(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
