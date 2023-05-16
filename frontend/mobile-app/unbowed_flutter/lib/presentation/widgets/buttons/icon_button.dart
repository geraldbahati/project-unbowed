import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      height: 500.0,
      color: Color(0xff333333),
      alignment: Alignment.center,
      transformAlignment: Alignment.center,
      child: Container(
        color: Colors.transparent,
        child: Container(
          width: 150,
          height: 150,
          child: Icon(
            Icons.star,
            size: 50,
            color: Colors.amber,
          ),
          decoration: BoxDecoration(
            color: Color(0xff333333),
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff4b4b4b),
                Color(0xff1b1b1b),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xff4b4b4b),
                offset: Offset(-19.3, -19.3),
                blurRadius: 41,
                spreadRadius: 0.0,
              ),
              BoxShadow(
                color: Color(0xff1b1b1b),
                offset: Offset(19.3, 19.3),
                blurRadius: 41,
                spreadRadius: 0.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
