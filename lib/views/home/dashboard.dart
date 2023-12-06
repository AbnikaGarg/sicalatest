import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';
import 'package:sica/views/home/homepage.dart';
import 'package:sica/views/shooting/shooting_list.dart';

import '../bottom_bar/bottom_bar.dart';
import '../events/tabbar/tab_bar.dart';
import '../profile/profile.dart';
import '../shooting/create_dop.dart';
import '../shooting/create_shooting.dart';
import '../shooting/shooting_details.dart';

class MyDashBoard extends StatefulWidget {
  MyDashBoard({super.key, required this.currentIndex});
  int currentIndex;

  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  //int _currentIndex = 0;

  final _inactiveColor = Color.fromARGB(255, 245, 241, 241);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(), bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    final activeColor = Theme.of(context).primaryColor;
    return CustomAnimatedBottomBar(
      containerHeight: 50.h,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedIndex: widget.currentIndex,
      showElevation: true,
      itemCornerRadius: 50,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        if (index == 2) {
          showModal(context);
        } else {
          setState(() => widget.currentIndex = index);
        }
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Home'),
          activeColor: activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.event_rounded),
          title: const Text('Events'),
          activeColor: activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(CupertinoIcons.video_camera_solid),
          title: const Text(
            'Shooting',
          ),
          activeColor: activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.person),
          title: const Text('Profile'),
          activeColor: activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0.r),
                      topRight: Radius.circular(30.0.r),
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Container(
                              width: 40.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Text(
                              "Shooting",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 18.sp),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateShooting()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60.h,
                                          width: 60.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            CupertinoIcons.video_camera_solid,
                                            color: AppTheme.bodyTextColor,
                                            size: 26.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("Create Shooting",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 12.sp)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateDOP()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60.h,
                                          width: 60.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            CupertinoIcons
                                                .plus_square_fill_on_square_fill,
                                            color: AppTheme.bodyTextColor,
                                            size: 24.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("Create DOP",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 12.sp)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ShootingList()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60.h,
                                          width: 60.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.list_rounded,
                                            color: AppTheme.bodyTextColor,
                                            size: 26.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("List",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 12.sp)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShootingDetail()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60.h,
                                          width: 60.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.approval_rounded,
                                            color: AppTheme.bodyTextColor,
                                            size: 26.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("Approval",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 12.sp)),
                                    ],
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 20.h,
                          ),
                        ]),
                  ),
                ),
              ));
        });
  }

  Widget getBody() {
    List<Widget> pages = [
      const Homepage(),
      EventsTabBar(),
      Center(child: const Text("Camera")),
      Profile(),
    ];
    return IndexedStack(
      index: widget.currentIndex,
      children: pages,
    );
  }
}
