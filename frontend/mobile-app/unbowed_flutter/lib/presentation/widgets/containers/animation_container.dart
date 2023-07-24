import 'package:flutter/material.dart';
import '../../animations/exclamation.dart';
import '../../styles/custom_box_decorators.dart';

import '../../animations/chat_animate.dart';
import '../../animations/circles.dart';

enum AnimationType { chat, exclamation, circles }

class CustomAnimationContainer extends StatelessWidget {
  final AnimationType animationType;
  final double height;
  final double width;
  final BoxDecoration? boxDecoration;

  final int? milliseconds;

  const CustomAnimationContainer(
    this.animationType, {
    super.key,
    required this.height,
    required this.width,
    this.boxDecoration,
    this.milliseconds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: boxDecoration ?? animatedBoxDecoration,
      child: Center(
        child: getAnimation(),
      ),
    );
  }

  Widget getAnimation() {
    switch (animationType) {
      case AnimationType.chat:
        return ChatAnimation(
          milliseconds: milliseconds,
        );
      case AnimationType.exclamation:
        return ExclamationAnimation(
          milliseconds: milliseconds,
        );

      case AnimationType.circles:
        return CirclesAnimation(
          milliseconds: milliseconds,
        );
      default:
        return const Placeholder();
    }
  }
}
