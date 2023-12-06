import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/theme.dart';
import 'discussion_form.dart';

class SelectForumType extends StatefulWidget {
  const SelectForumType({super.key});

  @override
  State<SelectForumType> createState() => _nameState();
}

class _nameState extends State<SelectForumType> {
  List forumType = [
    {"title": "MOVIES", "image": "assets/images/movie.png"},
    {"title": "PROJECTION", "image": "assets/images/projection.png"},
    {"title": "MEETING", "image": "assets/images/meeting.png"},
    {"title": "WORKSHOP", "image": "assets/images/workshop.png"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title:const Text("Discussion forum"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
            child: GridView.builder(
              itemCount: forumType.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 20.h,
                  crossAxisCount: 2,
                  mainAxisExtent: 120.h),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DiscussionForm()));
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Color(0x66000000),
                              BlendMode.darken,
                            ),
                            image: AssetImage(forumType[index]["image"])),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Text(
                        forumType[index]["title"],
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: AppTheme.whiteBackgroundColor),
                      ),
                    ),
                  ),
                );
              },
            )));
  }
}
