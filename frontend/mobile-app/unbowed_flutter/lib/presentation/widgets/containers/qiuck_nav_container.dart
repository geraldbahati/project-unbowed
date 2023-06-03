// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QuickNavContainer extends StatelessWidget {
  final double? width;
  final double? height;
  const QuickNavContainer({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // dimension
      width: width ?? 47.67.w,
      height: height ?? 31.16.h,

      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(56, 134, 235, 0.45),
            blurRadius: 20,
            offset: Offset(0, 20),
          ),
        ],
      ),
    );
  }
}
