import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';
import '../../components/filter_box.dart';
import 'grid_view.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
   List _category = ["All", "Images", "Videos"];
   int _selectIndex=0;
  @override
  Widget build(BuildContext context) {
    int selectedPos = 0;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: const Text("Gallery"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SICA AGM',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '10 Mar 23 | 10:00 AM',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_2_outlined,
                          color: Theme.of(context).primaryColor, size: 20.sp),
                      Text(
                        ' The SICA',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined,
                          color: Theme.of(context).primaryColor, size: 20.sp),
                      Text(
                        " 10 mar '23",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined,
                          color: Theme.of(context).primaryColor, size: 20.sp),
                      Text(
                        ' 222',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Wrap(
                children: [
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and "
                    "typesetting industry. Lorem Ipsum has been the "
                    "industry's standard dummy text ever since the 1500s, "
                    "when an unknown printer took a galley of type and "
                    "scrambled it to make a type specimen book. It has "
                    "survived not only five centuries",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  GestureDetector(
                    child: Text('see more',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12.sp,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      _category.length,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectIndex = index;
                              });
                            },
                            child: FilterBox(
                                index: index,
                                selectIndex: _selectIndex,
                                category: _category[index],
                                context: context),
                          )),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const GalleryGridView()
            ],
          ),
        ),
      ),
    );
  }
}
