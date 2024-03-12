import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/gallery_card.dart';
import '../../theme/theme.dart';
import 'gallery.dart';

class GalleryList extends StatefulWidget {
  const GalleryList({super.key});

  @override
  State<GalleryList> createState() => _nameState();
}

class _nameState extends State<GalleryList> {
  List galleryList = [
    {"title": "Movies", "image": "assets/images/website.png"},
  
    {"title": "Camera", "image": "assets/images/workshop.png"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: const Text("Gallery"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
            child: GridView.builder(
              itemCount: galleryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 20.h,
                  crossAxisCount: 2,
                  mainAxisExtent: 90.h),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(
                         builder: (context) => GalleryScreen(category: galleryList[index]["title"], categoryid: '',)));
                  },
                  child: GalleryWidget(galleryList: galleryList[index]),
                );
              },
            )));
  }
}
