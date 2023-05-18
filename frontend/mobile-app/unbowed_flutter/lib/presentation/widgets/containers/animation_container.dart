import 'package:flutter/material.dart';
import 'package:unbowed_flutter/presentation/styles/custom_box_decorators.dart';

class CustomAnimationContainer extends StatelessWidget {
  final double height;
  final double width;
  final BoxDecoration? boxDecoration;
  final Widget animation;

  const CustomAnimationContainer({
    super.key,
    required this.height,
    required this.width,
    required this.animation,
    this.boxDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: boxDecoration ?? animatedBoxDecoration,
      child: Center(
        child: animation,
      ),
    );
  }
}
