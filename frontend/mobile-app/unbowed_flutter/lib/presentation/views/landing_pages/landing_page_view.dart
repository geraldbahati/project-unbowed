import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/views/landing_pages/landing1.dart';
import 'package:unbowed_flutter/presentation/views/landing_pages/landing2.dart';

import '../../styles/text_styling.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.5.w),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(right: 5.5.w),
          alignment: Alignment.centerRight,
          child: Text(
            'ArtLife',
            style: appBarTextStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ),

      // landing widgets
      body: PageView(
        children: const [
          LandingPage(),
          LandingPage2(),
        ],
      ),

      // floating bottom button
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 5.5.w),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color.fromRGBO(26, 150, 220, 1),
          child: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
