import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/custom_box_decorators.dart';
import '../../styles/text_styling.dart';
import '../../widgets/containers/animation_container.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // first animation tile
                    CustomAnimationContainer(
                      AnimationType.exclamation,
                      height: 12.876.h,
                      width: 9.77.w,
                    ),

                    // 2nd image tile
                    Padding(
                      // 10 pixels
                      padding: EdgeInsets.symmetric(horizontal: 2.325581395.w),
                      child: Container(
                        width: 40.698.w,
                        height: 12.876.h,
                        decoration: greyBoxDecoration,
                      ),
                    ),

                    // 3rd image tile
                    Container(
                      width: 26.977.w,
                      height: 12.876.h,
                      decoration: greyBoxDecoration,
                    ),
                  ],
                ),

                SizedBox(height: 1.28755.h),

                // images 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // column images tile
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1st images tile
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 2nd image tile
                            Container(
                              width: 15.58.w,
                              height: 12.876.h,
                              decoration: greyBoxDecoration,
                            ),

                            // second animation tile
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.325581395.w),
                              child: CustomAnimationContainer(
                                AnimationType.chat,
                                height: 12.876.h,
                                width: 35.116.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.28755.h),
                        // 2nd image tile
                        Container(
                          width: 53.022325581.w,
                          height: 12.876.h,
                          decoration: greyBoxDecoration,
                        ),
                      ],
                    ),

                    // 3rd image tiles
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 26.977.w,
                          height: 20.6.h,
                          decoration: greyBoxDecoration,
                        ),
                        SizedBox(height: 1.28755.h),

                        // 3rd animation tile
                        CustomAnimationContainer(
                          AnimationType.circles,
                          height: 5.15.h,
                          width: 26.977.w,
                        ),
                      ],
                    )
                  ],
                )
              ],
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
                  Text(
                    "Create Productive Work, Right Now",
                    style: titleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Collaborate, create and keep track of your project, easily and effectively.",
                    style: contextTextStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
