import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/animations/slide_in.dart';

import '../../styles/custom_box_decorators.dart';
import '../../styles/text_styling.dart';

class LandingPage2 extends StatelessWidget {
  const LandingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.only(left: 8.84.w, right: 8.8.w, top: 3.97.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // images part
            SlideInAnimation(
              offset: const Offset(50.0, 0.0),
              durationInMilliseconds: 400,
              delayInMilliSeconds: 100,
              child: Container(
                width: 82.1.w,
                height: 41.2.h,
                decoration: greyBoxDecoration,
              ),
            ),

            SizedBox(height: 4.077.h),
            // text part
            SizedBox(
              width: double.infinity,
              height: 19.1.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideInAnimation(
                    offset: const Offset(50, 0),
                    durationInMilliseconds: 400,
                    delayInMilliSeconds: 100,
                    applyOpacity: true,
                    child: Text(
                      "Create Productive Work, Right Now",
                      style: titleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SlideInAnimation(
                    offset: const Offset(80, 0.0),
                    durationInMilliseconds: 400,
                    delayInMilliSeconds: 100,
                    applyOpacity: true,
                    child: Text(
                      "Collaborate, create and keep track of your project, easily and effectively.",
                      style: contextTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
