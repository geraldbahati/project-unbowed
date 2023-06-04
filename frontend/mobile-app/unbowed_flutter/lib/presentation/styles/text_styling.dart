import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

TextStyle appBarTextStyle = TextStyle(
  color: const Color.fromRGBO(26, 150, 220, 1),
  fontSize: 22.sp,
  fontWeight: FontWeight.bold,
  fontFamily: "Poppins",
);

final titleTextStyle = GoogleFonts.poppins(
  color: const Color.fromRGBO(3, 5, 61, 1),
  fontSize: 24.sp,
  fontWeight: FontWeight.bold,
);

final contextTextStyle = GoogleFonts.poppins(
  color: const Color.fromRGBO(3, 5, 61, 1),
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
);

final helloTextStyle = GoogleFonts.inter(
  fontSize: 22.sp,
  fontWeight: FontWeight.bold,
);

final homeNameTextStyle = GoogleFonts.lato(
  fontSize: 18.sp,
  fontWeight: FontWeight.w600,
);

final detailTextStyle = GoogleFonts.inter(
  fontSize: 12.sp,
  color: Color.fromRGBO(52, 53, 55, 0.612),
);

final subTextStyle = GoogleFonts.inter(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
);
