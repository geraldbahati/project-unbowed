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
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5.w),
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
        // background color
        backgroundColor: Colors.white.withOpacity(0.2),
        extendBody: true,

        // appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
            imageUrl: 'https://i.imgur.com/BoN9kdC.png',
          ),
        ),

        // body
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 7.44.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.22.h,
                    ),
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
                      "Let's clean and manage your files",
                      style: detailTextStyle,
                    ),
                  ],
                ),
              ),

              // quick nav containers
              SizedBox(
                height: 38.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 7.44.w,
                          right: index == 2 ? 7.44.w : 0,
                        ),
                        child: QuickNavContainer(),
                      ),
                    );
                  },
                ),
              ),

              // categories
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.44.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Categories",
                      style: subTextStyle,
                    ),

                    Text(
                      "Total 23 files",
                      style: detailTextStyle,
                    ),

                    SizedBox(
                      height: 2.146.h,
                    ),

                    // categories list

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 15,
                        childAspectRatio: 2,
                      ),
                      itemBuilder: (context, index) {
                        return const Center(child: FolderContainer());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
