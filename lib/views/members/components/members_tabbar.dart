import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/models/OtherMemberProfile.dart';

import 'package:sica/theme/theme.dart';
import '../../events/events.dart';
import '../commented_forum.dart';
import '../films_tab.dart';
import '../members_about_tab.dart';


class MembersTabBar extends StatelessWidget {
   final MemberBasicDetails memberdetail;
  const MembersTabBar({
    super.key, required this.memberdetail,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        //backgroundColor: AppTheme.backGround,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              //  color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x8C333335).withOpacity(0.4),
                  offset: Offset(
                    0.0,
                    1.0,
                  ),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(child: Container()),
                        TabBar(
                          indicatorWeight: 2,
                          indicatorColor: Theme.of(context).primaryColor,
                          isScrollable: false,
                          tabs: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: const Text("About"),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: 12.h),
                            //   child: const Text("Forum"),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: const Text("Work"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body:  TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            MemberAboutTab(memberdetails: memberdetail),
           // DiscussionCommented(),
            FilmsTab(memberdetails: memberdetail),
          ],
        ),
      ),
    );
  }
}
