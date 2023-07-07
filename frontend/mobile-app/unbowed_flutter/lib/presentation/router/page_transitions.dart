import 'package:flutter/material.dart';

class CircularPageRoute extends PageRouteBuilder {
  CircularPageRoute({required WidgetBuilder builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CircularTransition(animation, child);
          },
        );
}

class CircularTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const CircularTransition(this.animation, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ClipOval(
          clipper: CircleClipper(animation.value),
          child: child,
        );
      },
      child: child,
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  final double animationValue;

  CircleClipper(this.animationValue);

  @override
  Rect getClip(Size size) {
    final offset = Offset(size.width / 2, size.height / 2);
    final radius = animationValue * size.longestSide;
    return Rect.fromCircle(center: offset, radius: radius);
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) {
    return animationValue != oldClipper.animationValue;
  }
}
