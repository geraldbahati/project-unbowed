import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/styles/text_styling.dart';

import '../../widgets/containers/bottom_navigation_bar.dart';
import '../../widgets/containers/folder_container.dart';
import '../../widgets/containers/profile_box.dart';
import '../../widgets/containers/qiuck_nav_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 238, 248, 1),

      // appbar
      appBar: AppBar(
        // settings, notification icons
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],

        // profile picture
        leading: const ProfileBox(
          size: 60,
          isBox: true,
          // imageUrl: 'https://i.imgur.com/BoN9kdC.png',
        ),
      ),

      // body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // welcome texts
          Text(
            "Hello!",
            style: helloTextStyle,
          ),

          SizedBox(
            height: 1.073.h,
          ),
          Text(
            "Gerald Bahati",
            style: homeNameTextStyle,
          ),

          SizedBox(
            height: 1.073.h,
          ),

          Text(
            "Let's clean and managee your files",
            style: detailTextStyle,
          ),

          // quick nav containers

          QuickNavContainer(),

          // categories
          Text(
            "Categories",
            style: subTextStyle,
          ),

          Text(
            "Totak 23 files",
            style: detailTextStyle,
          ),

          // categories list
          FolderContainer(),
        ],
      ),

      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
