import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../animations/controlled_slide_in.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  late final AnimationController _selectedController;
  late final AnimationController _unselectedController;

  late int _selectedIndex;
  late int _previousIndex;
  double _iconOpacity = 0;
  bool _isFirstTime = true;
  final double _textOpacity = 0;

  final List<IconData> icons = [
    Icons.home,
    Icons.search,
    // Icons.add,
    // Icons.notifications,
    // Icons.person,
  ];

  @override
  void initState() {
    super.initState();

    _selectedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _unselectedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final int index = icons.length ~/ 2;
    _selectedIndex = index;
    _previousIndex = index;
  }

  @override
  void dispose() {
    _selectedController.dispose();
    _unselectedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Background
        SizedBox(
          height: 15.2360515.h,
          width: double.infinity,
        ),
        Container(
          height: 10.73.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.67),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: icons.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / icons.length,
                child: GestureDetector(
                  onTap: () {
                    if (_selectedIndex != index) {
                      _onItemTapped(index, _selectedIndex);
                    }
                  },
                  child: Container(
                    color: Colors.white.withOpacity(0.67),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildIcon(index), // Display the icon
                        _buildText(index), // Display the text
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Active container
        AnimatedPositioned(
          // curve: Curves.easeIn,
          duration: const Duration(milliseconds: 300),
          bottom: 6.65606515.h,
          left: _activePosition(_selectedIndex),
          child: Container(
              width: 18.60.w,
              height: 8.58.h,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(56, 136, 235, 1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(133, 172, 244, 0.6),
                    spreadRadius: 2,
                    blurRadius: 16,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: _buildContainerIcon(_selectedIndex)),
        ),
      ],
    );
  }

  Widget _buildIcon(int index) {
    if (_selectedIndex == index) {
      // Selected icon
      return Opacity(
        opacity: _iconOpacity,
        child: Icon(
          icons[index],
          color: const Color.fromRGBO(0, 0, 0, 0.54),
        ),
      );
    } else if (index == _previousIndex) {
      // Unselected icon
      return ControlledSlideInAnimation(
        animationController: _unselectedController,
        start: const Offset(0, -30),
        child: Icon(
          icons[index],
          color: const Color.fromRGBO(0, 0, 0, 0.54),
        ),
      );
    } else {
      // Inactive icon
      return Icon(
        icons[index],
        color: const Color.fromRGBO(0, 0, 0, 0.54),
      );
    }
  }

  Widget _buildText(int index) {
    if (_selectedIndex == index) {
      if (_isFirstTime) {
        // Selected text (first time)
        return Text(
          "Home",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
            color: const Color.fromRGBO(56, 136, 235, 1),
          ),
        );
      } else {
        // Selected text
        return ControlledSlideInAnimation(
          animationController: _selectedController,
          start: const Offset(0, 30),
          child: Text(
            "Home",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: const Color.fromRGBO(56, 136, 235, 1),
            ),
          ),
        );
      }
    } else {
      // Inactive text
      return Opacity(
        opacity: _textOpacity,
        child: Text(
          "Home",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
            color: const Color.fromRGBO(56, 136, 235, 1),
          ),
        ),
      );
    }
  }

  Widget _buildContainerIcon(int index) {
    if (_selectedIndex == index) {
      if (_isFirstTime) {
        // Selected text (first time)
        return Icon(
          icons[_selectedIndex],
          size: 3.65.h,
          color: Colors.white,
        );
      } else {
        // Selected text
        return ControlledSlideInAnimation(
          animationController: _unselectedController,
          start: const Offset(0, 30),
          child: Icon(
            icons[_selectedIndex],
            size: 3.65.h,
            color: Colors.white,
          ),
        );
      }
    } else {
      // Inactive text
      return Container();
    }
  }

  void _onItemTapped(int index, int previousIndex) {
    _onItemUnselected(previousIndex);

    setState(() {
      _selectedIndex = index;
      _iconOpacity = 0;
      _isFirstTime = false;
    });

    _selectedController.forward();

    _unselectedController.forward();
  }

  void _onItemUnselected(int index) {
    _unselectedController.reset();
    _selectedController.reset();

    setState(() {
      _previousIndex = index;
    });

    _unselectedController.forward();
  }

  double _activePosition(int index) {
    var width = MediaQuery.of(context).size.width;

    return ((width / icons.length) * index) +
        ((width / icons.length) / 2.0 - 18.60.w / 2.0);
  }
}
