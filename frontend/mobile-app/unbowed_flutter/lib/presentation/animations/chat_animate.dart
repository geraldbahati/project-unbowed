import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';
import '../styles/theme.dart';

class ChatAnimation extends StatefulWidget {
  final int? milliseconds;
  const ChatAnimation({
    super.key,
    this.milliseconds,
  });

  @override
  State<ChatAnimation> createState() => _ChatAnimationState();
}

class _ChatAnimationState extends State<ChatAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _chatController;

  late final Animation<Alignment> _chatAlignAnimation;
  late final Animation<Alignment> _commentAlignAnimation;

  Future<void> _playDelayedAnimation() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Delay between the two animations
    _chatController.forward(); // Start the second animation
    _chatController.addStatusListener((status) {
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _chatController = AnimationController(
      duration: Duration(milliseconds: widget.milliseconds ?? 1000),
      vsync: this,
    );

    _chatAlignAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight:
              1.0, // Weight of the first segment (0% to 50% of the animation)
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight:
              1.0, // Weight of the second segment (50% to 100% of the animation)
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _chatController,
        curve: Curves.easeInOut,
      ),
    );

    _commentAlignAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight:
              1.0, // Weight of the first segment (0% to 50% of the animation)
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight:
              1.0, // Weight of the second segment (50% to 100% of the animation)
        ),
      ],
    ).animate(
        CurvedAnimation(parent: _chatController, curve: Curves.easeInOut));

    _playDelayedAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26.w,
      height: 9.98.h,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _commentAlignAnimation,
            builder: (context, child) {
              return Align(
                alignment: _commentAlignAnimation.value,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                  child: Image.asset(
                    commentIcon,
                    width: 18.w,
                    height: 6.5.h,
                    fit: BoxFit.fill,
                    color: lightBlue,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _chatAlignAnimation,
            builder: (context, child) {
              return Align(
                alignment: _chatAlignAnimation.value,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                  child: Image.asset(
                    chatIcon,
                    width: 18.w,
                    height: 6.5.h,
                    fit: BoxFit.fill,
                    color: darkBlue,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
