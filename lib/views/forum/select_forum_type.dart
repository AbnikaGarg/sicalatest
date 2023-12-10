import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/services/forum_repo.dart';
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
  List? categories;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    final service = Forum();
    service.getForumCat().then((value) {
      if (value.isNotEmpty) {
        categories = value[0];
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: const Text("Discussion forum"),
        ),
        body: categories == null
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 16,
                  color: Colors.yellow,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
                child: GridView.builder(
                  itemCount: categories!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                      crossAxisCount: 2,
                      mainAxisExtent: 100.h),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DiscussionForm(category:  categories![index],)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Color(0x66000000),
                                  BlendMode.darken,
                                ),
                                image: AssetImage("assets/images/workshop.png")),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          categories![index]["category_name"],
                          style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.whiteBackgroundColor),
                        ),
                      ),
                    );
                  },
                )));
  }
}
