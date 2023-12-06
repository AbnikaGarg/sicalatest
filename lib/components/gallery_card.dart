import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

class GalleryWidget extends StatelessWidget {
  GalleryWidget({
    super.key,
    required this.galleryList,
  });
  var galleryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 155.w,
      // alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter:const ColorFilter.mode(
                Color.fromARGB(102, 92, 82, 82),
                BlendMode.darken,
              ),
              image: AssetImage(galleryList["image"])),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h, left: 6.w, right: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              galleryList["title"],
              style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.whiteBackgroundColor),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "10 Mar '23",
                  style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.whiteBackgroundColor),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.folder_copy_rounded,
                      size: 16.sp,
                      color:AppTheme.primaryColor,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                     Text(
                      '5',
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
