import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/constants.dart';
import 'package:unbowed_flutter/presentation/styles/theme.dart';

class ExclamationAnimation extends StatefulWidget {
  const ExclamationAnimation({super.key});

  @override
  State<ExclamationAnimation> createState() => _ExclamationAnimationState();
}

class _ExclamationAnimationState extends State<ExclamationAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _heightAnimation;

  startAnimation() {
    _controller.forward();
    _controller.addStatusListener((status) {
      setState(() {});
      if (status == AnimationStatus.completed) {
        // When the animation completes, resize the icon back to its original size.
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // When the animation completes, resize the icon back to its original size.
        _controller.forward();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 2.79.w, end: 4.65.w).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );

    _heightAnimation = Tween<double>(begin: 6.22.h, end: 10.3.h).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );

    startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      width: _widthAnimation.value,
      height: _heightAnimation.value,
      child: Image.asset(
        exclamationIcon,
        fit: BoxFit.cover,
        color: lightBlue,
      ),
    );
  }
}
