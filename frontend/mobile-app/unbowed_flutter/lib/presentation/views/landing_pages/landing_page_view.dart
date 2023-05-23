import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/styles/theme.dart';
import 'package:unbowed_flutter/presentation/views/landing_pages/landing1.dart';
import 'package:unbowed_flutter/presentation/views/landing_pages/landing2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../styles/text_styling.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late final PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
              LandingPage(),
              LandingPage2(),
            ],
          ),
          // dot indicator
          Align(
            alignment: const Alignment(-0.75, 0.75),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: const ScrollingDotsEffect(
                activeDotColor: darkBlue,
                dotColor: Color.fromRGBO(26, 150, 220, 0.5),
                dotHeight: 8,
                dotWidth: 8,
                spacing: 8,
              ),
            ),
          ),
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
