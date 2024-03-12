import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/theme/theme.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/account_type.dart/account_type.dart';
import 'package:sica/views/awards/awards.dart';
import 'package:sica/views/gallery/gallery_list.dart';
import 'package:sica/views/login/login.dart';
import 'package:sica/views/members/members.dart';
import 'package:sica/views/vendors/vendors.dart';

import '../../../utils/images.dart';
import '../../forum/select_forum_type.dart';
import '../../polls/polls.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isRemember = preferences.getBool('isRemember');

    preferences.clear();
    DialogHelp.showLoading(context);
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => AccountType(),
      ),
      (Route route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width / 1.5,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              // Remove padding
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Image.asset(
                  Images.logo2,
                  height: 40.h,
                  fit: BoxFit.contain,
                ),
                // Divider(
                // //  color: Colors.grey[300],
                // ),
                SizedBox(
                  height: 30.h,
                ),
                Text("Discover",
                    style: Theme.of(context).textTheme.headlineMedium!),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectForumType()));
                  },
                  child: _buildIconwithText("Forum", "forum", context),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GalleryList(),
                      ),
                    );
                  },
                  child: _buildIconwithText("Gallery", "gallery", context),
                ),
                // GestureDetector(
                //   behavior: HitTestBehavior.opaque,
                //   onTap: () {
                //     Navigator.pop(context);
                //    Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const Awards(),
                //       ),
                //     );
                //   },
                //   child:_buildIconwithText("SICA Awards", "award", context),
                // ),

                // SizedBox(
                //   height: 30.h,
                // ),
                // Text("Shop",
                //     style: Theme.of(context).textTheme.headlineMedium!),
                // _buildIconwithText("SICA Products", "shop", context),
                //   SizedBox(
                //     height: 30.h,
                //   ),
                // Text("User",
                //   style: Theme.of(context).textTheme.headlineMedium!),
                //   GestureDetector(
                //     behavior: HitTestBehavior.opaque,
                //     onTap: () {
                //        Navigator.pop(context);
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const Polls(),
                //         ),
                //       );
                //     },
                //     child: _buildIconwithText("Polls", "polls", context),
                //   ),
                // GestureDetector(
                //   behavior: HitTestBehavior.opaque,
                //   onTap: () {
                //     Navigator.pop(context);

                //   },
                //   child: _buildIconwithText("Employment", "employement", context),
                // ),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Members()));
                  },
                  child: _buildIconwithText("Members", "member", context),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Vendors()));
                  },
                  child: _buildIconwithText("Vendors", "vendors", context),
                ),

                SizedBox(
                  height: 30.h,
                ),
                Text("Account",
                    style: Theme.of(context).textTheme.headlineMedium!),
                _buildIconwithText("Support", "support", context),
                Padding(
                  padding: EdgeInsets.only(top: 18.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Privacy Policy",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 15.sp),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_document,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Terms & Conditions",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 15.sp),
                      )
                    ],
                  ),
                ),
               
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    logout();
                  },
                  child: _buildIconwithText("Logout", "logout", context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildIconwithText(String text, String svg, context) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/$svg.svg",
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 6.w,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 15.sp),
          )
        ],
      ),
    );
  }
}
