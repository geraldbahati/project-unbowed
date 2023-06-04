import 'package:flutter/material.dart';

class ControlledSlideInAnimation extends StatefulWidget {
  final AnimationController animationController;
  final Offset start;
  final Offset end;
  final bool isDiplayed;

  final Widget child;
  const ControlledSlideInAnimation({
    super.key,
    required this.animationController,
    this.start = Offset.zero,
    this.end = Offset.zero,
    this.isDiplayed = false,
    required this.child,
  });

  @override
  State<ControlledSlideInAnimation> createState() =>
      _ControlledSlideInAnimationState();
}

class _ControlledSlideInAnimationState
    extends State<ControlledSlideInAnimation> {
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //_____________opacity animation_____________
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(widget.animationController);
    //_____________opacity animation_____________

    //_____________slide animation_____________
    final Tween<Offset> slideTween = Tween<Offset>(
      begin: widget.start,
      end: widget.end,
    );

    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeIn,
    );

    _offsetAnimation = slideTween.animate(curvedAnimation);
    //_____________slide animation_____________
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) => Opacity(
        opacity: _opacityAnimation.value,
        child: Transform.translate(
          offset: _offsetAnimation.value,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
