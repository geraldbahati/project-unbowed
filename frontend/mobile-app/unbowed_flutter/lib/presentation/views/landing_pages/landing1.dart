import 'package:flutter/material.dart';
import 'package:unbowed_flutter/presentation/styles/custom_box_decorators.dart';

import '../../styles/text_styling.dart';
import 'package:sizer/sizer.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
        leading: Padding(
          padding: EdgeInsets.only(left: 3.1.w),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(right: 3.1.w),
          alignment: Alignment.centerRight,
          child: Text(
            'ArtLife',
            style: appBarTextStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ),

      // body
      body: SingleChildScrollView(
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
                      Container(
                        width: 9.77.w,
                        height: 12.876.h,
                        decoration: animatedBoxDecoration,
                      ),

                      // 2nd image tile
                      Padding(
                        // 10 pixels
                        padding:
                            EdgeInsets.symmetric(horizontal: 2.325581395.w),
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
                                child: Container(
                                  width: 35.116.w,
                                  height: 12.876.h,
                                  decoration: animatedBoxDecoration,
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
                          Container(
                              width: 26.977.w,
                              height: 5.15.h,
                              decoration: animatedBoxDecoration)
                        ],
                      )
                    ],
                  )
                ],
              ),

              // text part
              Container(
                width: 75.w,
                height: 21.89.h,
                color: Colors.pink,
              )
            ],
          ),
        ),
      ),
    );
  }
}
