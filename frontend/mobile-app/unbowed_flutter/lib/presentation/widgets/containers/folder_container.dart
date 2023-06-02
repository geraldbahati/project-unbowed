import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/constants.dart';

class FolderContainer extends StatelessWidget {
  const FolderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // dimension
        width: 40.7.w,
        height: 9.23.h,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.67),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // folder icon
            Padding(
              padding: EdgeInsets.only(left: 4.65.w),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.asset(
                    folderIcon,
                    width: 11.40.w,
                    height: 3.93.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 4.67,
                    left: 5.0,
                    child: Image.asset(
                      googleDocsIcon,
                      scale: 30,
                    ),
                  ),
                ],
              ),
            ),

            // folder name
            Padding(
              padding: EdgeInsets.only(left: 4.65.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pictures",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Color.fromRGBO(0, 0, 0, 0.87),
                    ),
                  ),

                  // folder size
                  Text(
                    "2360 items",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 8.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
