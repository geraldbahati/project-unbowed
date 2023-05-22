import 'package:flutter/material.dart';

class SlideDownAnimation extends StatefulWidget {
  final Alignment initialPosition;
  final Alignment finalPosition;
  final int durationInMilliseconds;
  final Widget child;
  final int? delayInMilliSeconds;
  final bool applyOpacity;
  final Offset offset;

  const SlideDownAnimation({
    super.key,
    this.initialPosition = Alignment.center,
    this.finalPosition = Alignment.center,
    required this.durationInMilliseconds,
    this.delayInMilliSeconds,
    this.applyOpacity = false,
    this.offset = Offset.zero,
    required this.child,
  });

  @override
  State<SlideDownAnimation> createState() => _SlideDownAnimationState();
}

class _SlideDownAnimationState extends State<SlideDownAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Alignment> _animation;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _offsetAnimation;

  Future<void> _playAnimation() async {
    await Future.delayed(
      Duration(
        milliseconds: widget.delayInMilliSeconds ?? 0,
      ),
    );

    _animationController.forward();
    _animationController.addStatusListener((status) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationInMilliseconds),
    );

    final Tween<Offset> offsetTween = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    );

    final CurvedAnimation offsetCurve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _offsetAnimation = offsetTween.animate(offsetCurve);

    final Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);

    final CurvedAnimation opacityCurve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );

    _opacityAnimation = opacityTween.animate(opacityCurve);

    final Tween<Alignment> tween = Tween<Alignment>(
      begin: widget.initialPosition,
      end: widget.finalPosition,
    );

    final CurvedAnimation curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animation = tween.animate(curve);
    _playAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: _offsetAnimation.value,
          child: AnimatedAlign(
            alignment: _animation.value,
            duration: Duration(milliseconds: widget.durationInMilliseconds),
            child: Opacity(
              opacity: widget.applyOpacity ? _opacityAnimation.value : 1,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
