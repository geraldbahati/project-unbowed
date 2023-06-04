import 'package:flutter/material.dart';

class BounceInAnimation extends StatefulWidget {
  const BounceInAnimation({super.key});

  @override
  State<BounceInAnimation> createState() => _BounceInAnimationState();
}

class _BounceInAnimationState extends State<BounceInAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  Future<void> _playAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));

    _controller.forward();
    _controller.addStatusListener((status) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    final Tween<double> tween = Tween<double>(begin: 0.0, end: 1.0);
    final CurvedAnimation curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    _animation = tween.animate(curve);
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (_animation.value * 0.2),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: Text(
        'Hello',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
