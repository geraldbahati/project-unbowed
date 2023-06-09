import 'dart:ui';

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
    Icons.add,
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
    var itemWidth = MediaQuery.of(context).size.width / icons.length;
    double barHeight = 13.9485.h;
    double containerHeight = 6.44.h;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Background
        SizedBox(
          height: barHeight,
          width: double.infinity,
        ),
        ClipRRect(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: itemWidth / 2),
            height: 10.73.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.42),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (_selectedIndex != index) {
                        _onItemTapped(index, _selectedIndex);
                      }
                    },
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width - itemWidth) /
                          icons.length,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildIcon(index), // Display the icon
                          _buildText(index), // Display the text
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        // Active container
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: barHeight - containerHeight,
          left: _activePosition(_selectedIndex),
          child: Container(
              width: 13.95.w,
              height: containerHeight,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(56, 136, 235, 1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(133, 172, 244, 0.6),
                    spreadRadius: 2,
                    blurRadius: 16,
                    offset: Offset(0, 15),
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
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
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
    var validWidth = width - (width / icons.length);
    var itemWidth = validWidth / icons.length;
    var offset = itemWidth / 2 - 13.95.w / 2;

    return itemWidth * index + offset + (width / icons.length) / 2;
  }
}
