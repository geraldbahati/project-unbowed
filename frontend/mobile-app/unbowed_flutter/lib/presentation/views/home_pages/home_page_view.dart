import 'package:flutter/material.dart';

import '../../widgets/containers/bottom_navigation_bar.dart';
import 'chat_screen.dart';
import 'home_screen.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(211, 233, 244, 0.96),
            Color.fromRGBO(233, 209, 241, 0.93),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.2),
        extendBody: true,
        body: PageView(
          controller: _pageController,
          children: const [
            ChatScreen(),
            HomeView(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          pageController: _pageController,
        ),
      ),
    );
  }
}
