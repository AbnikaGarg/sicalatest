import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_share/flutter_share.dart';
import 'detail_screen.dart';
import 'grid_data.dart';

class GalleryGridView extends StatelessWidget {
  const GalleryGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> gridList = [
      GridData(1, 'Photography 1', 'assets/images/news1.jpg'),
      GridData(2, 'Photography 2', 'assets/images/img1.jpeg'),
      GridData(3, 'Photography 3', 'assets/images/news2.jpg'),
      GridData(4, 'Photography 4', 'assets/images/img2.jpeg'),
      GridData(5, 'Photography 5', 'assets/images/director.png'),
      GridData(6, 'Photography 6', 'assets/images/joker.png'),
      GridData(7, 'Photography 7', 'assets/images/director.png'),
      GridData(8, 'Photography 8', 'assets/images/img1.jpeg'),
      GridData(9, 'Photography 9', 'assets/images/img2.jpeg'),
      GridData(10, 'Photography 10', 'assets/images/director.png'),
      GridData(11, 'Photography 12', 'assets/images/girl.png'),
    ];
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 14,
      itemCount: gridList.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          img: gridList[index].image,
                          text: gridList[index].name,
                        )));
          },
          child: tile(index, gridList, context),
        );
      },
    );
  }

  tile(int index, List<dynamic> gridList, context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              gridList[index].image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 12.h, bottom: 12.h, left: 6.w, right: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(gridList[index].name,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                GestureDetector(
                    onTap: () {
                      _share(this, gridList[index].name, gridList[index].image);
                    },
                    child: Icon(
                      Icons.more_vert,
                      size: 20.sp,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _share(context, name, image) async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }
}
