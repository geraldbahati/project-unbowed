import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/styles/theme.dart';

class CirclesAnimation extends StatefulWidget {
  final int? milliseconds;
  const CirclesAnimation({
    super.key,
    this.milliseconds,
  });

  @override
  State<CirclesAnimation> createState() => _CirclesAnimationState();
}

class _CirclesAnimationState extends State<CirclesAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Alignment> _circleAnimation;
  late final Animation<Alignment> _outlinedAnimation;
  late final int _milliseconds;

  Future<void> _playAnimation() async {
    // await Future.delayed(const Duration(milliseconds: 500));
    _controller.forward();
    _controller.addStatusListener((status) {
      setState(() {});

      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _milliseconds = widget.milliseconds ?? 500;

    _controller = AnimationController(
      duration: Duration(milliseconds: _milliseconds),
      vsync: this,
    );

    _circleAnimation = Tween<Alignment>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    _outlinedAnimation = Tween<Alignment>(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    _playAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 13.5.w,
      height: 4.h,
      // color: Colors.grey,
      child: Stack(
        children: [
          AnimatedAlign(
            duration: Duration(milliseconds: _milliseconds),
            alignment: _outlinedAnimation.value,
            child: Stack(
              children: [
                Icon(
                  Icons.circle_rounded,
                  size: 4.h,
                  color: Colors.white,
                ),
                Icon(
                  Icons.circle_outlined,
                  size: 4.h,
                  color: darkBlue,
                ),
              ],
            ),
          ),
          AnimatedAlign(
            duration: Duration(milliseconds: _milliseconds),
            alignment: _circleAnimation.value,
            child: Icon(
              Icons.circle_rounded,
              size: 4.h,
              color: darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
