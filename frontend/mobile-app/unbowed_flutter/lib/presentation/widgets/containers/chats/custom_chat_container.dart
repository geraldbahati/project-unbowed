// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperPath(), // Custom path for clipping
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.65,
        ),
        decoration: BoxDecoration(
          // color: Colors.orange,
          color: Colors.white.withOpacity(0.42),
          borderRadius: BorderRadius.circular(13.33.sp),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(2.64.w, 1.51.h, 2.64.w, 0.97.h),
          child: Text(
            message,
            // "I am better",
            textAlign: TextAlign.start,
            textWidthBasis: TextWidthBasis.longestLine,
            style: GoogleFonts.leagueSpartan(
              fontSize: 15.sp,
            ),
            // style: chatRoomTitleTextStyle,
          ),
        ),
      ),
    );
  }
}

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Define your custom shape here using path.moveTo(), path.lineTo(), etc.
    path.lineTo(0, size.height - 3.451996.h);

    var firstControlPoint = Offset(0.05495.w, size.height - 9.4358.h);
    var firstEndPoint = Offset(0.2198.w, size.height - 3.3873.h);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(0.3978.w, size.height - 3.33001.h);
    var secondEndPoint = Offset(0.6593.w, size.height - 3.2362.h);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(0.8791.w, size.height - 3.1521.h);
    var thirdEndPoint = Offset(1.0989.w, size.height - 3.0593.h);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    var fourthControlPoint = Offset(1.3187.w, size.height - 2.9666.h);
    var fourthEndPoint = Offset(1.7692.w, size.height - 2.7184.h);
    path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy,
        fourthEndPoint.dx, fourthEndPoint.dy);

    var fifthControlPoint = Offset(2.182.w, size.height - 2.4542.h);
    var fifthEndPoint = Offset(2.4945.w, size.height - 2.1974.h);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fifthEndPoint.dx, fifthEndPoint.dy);

    var sixthControlPoint = Offset(2.7473.w, size.height - 1.9417.h);
    var sixthEndPoint = Offset(2.8725.w, size.height - 1.7929.h);
    path.quadraticBezierTo(sixthControlPoint.dx, sixthControlPoint.dy,
        sixthEndPoint.dx, sixthEndPoint.dy);

    var seventhControlPoint = Offset(2.9802.w, size.height - 1.6451.h);
    var seventhEndPoint = Offset(3.1495.w, size.height - 1.3484.h);
    path.quadraticBezierTo(seventhControlPoint.dx, seventhControlPoint.dy,
        seventhEndPoint.dx, seventhEndPoint.dy);

    var eighthControlPoint = Offset(3.2527.w, size.height - 1.05178.h);
    var eighthEndPoint = Offset(3.2967.w, size.height - 0.7551.h);
    path.quadraticBezierTo(eighthControlPoint.dx, eighthControlPoint.dy,
        eighthEndPoint.dx, eighthEndPoint.dy);

    var ninthControlPoint = Offset(3.2747.w, size.height - 0.3776.h);
    var ninthEndPoint = Offset(3.2264.w, size.height - 0.1888.h);
    path.quadraticBezierTo(ninthControlPoint.dx, ninthControlPoint.dy,
        ninthEndPoint.dx, ninthEndPoint.dy);

    var tenthControlPoint = Offset(3.1978.w, size.height - 0.0939.h);
    var tenthEndPoint = Offset(3.1824.w, size.height - 0.0475.h);
    path.quadraticBezierTo(tenthControlPoint.dx, tenthControlPoint.dy,
        tenthEndPoint.dx, tenthEndPoint.dy);

    // path.lineTo(size.width * 0.05495, size.height * 0.9061);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; // Return true to force the clipper to redraw when the shape changes
  }
}
