import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/views/profile/add_socialsLinks.dart';
import 'package:sica/views/profile/profile.dart';

import '../../theme/theme.dart';

class MemberAboutTab extends StatefulWidget {
  const MemberAboutTab({super.key, required this.memberdetails});
  final MemberBasicDetails memberdetails;

  @override
  State<MemberAboutTab> createState() => _nameState();
}

class _nameState extends State<MemberAboutTab> {
  List socialLinks = [
    {"image": "facebook.png", "title": "Facebook"},
    {"image": "insta.png", "title": "Insta"},
    {"image": "youtube.png", "title": "youtube"},
    {"image": "twiter.png", "title": "twiter"},
    {"image": "linkedin.png", "title": "linkedin"}
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.memberdetails.memberDetails!.image.toString() != "")
                  Container(
                    height: 80.h,
                    width: 80.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget
                            .memberdetails.memberDetails!.image
                            .toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    height: 80.h,
                    width: 80.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/profile.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            widget.memberdetails.memberDetails!.name.toString(),
                            style: Theme.of(context).textTheme.headlineMedium!),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          widget.memberdetails.memberDetails!.designation
                              .toString(),
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: 1,
                  text: TextSpan(
                    text: 'M.no:',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 18.sp,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              '  ${widget.memberdetails.memberDetails!.membershipNo.toString()}',
                          style: TextStyle(
                            fontSize: 14.sp,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80.w,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.calendar,
                      size: 22.h,
                    ),
                    Text(
                        ' ${widget.memberdetails.memberDetails!.joiningDate.toString()}',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 14.sp,
                                )),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Text("Skills", style: Theme.of(context).textTheme.headlineMedium!),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "${widget.memberdetails.memberDetails!.skills.toString()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: 25.h,
            ),
            Text("Medium", style: Theme.of(context).textTheme.headlineMedium!),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "${widget.memberdetails.memberDetails!.medium.toString()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: 25.h,
            ),
            Text("Portfolio Link",
                style: Theme.of(context).textTheme.headlineMedium!),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "${widget.memberdetails.memberDetails!.portifolioLink.toString()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Socials Link",
                    style: Theme.of(context).textTheme.headlineMedium!),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.memberdetails.memberDetails!.facebookLink
                            .toString() !=
                        "")
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: SocialLinks(socialLinks: socialLinks[0]),
                      ),
                    if (widget.memberdetails.memberDetails!.instagramLink
                            .toString() !=
                        "")
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: SocialLinks(socialLinks: socialLinks[1]),
                      ),
                    if (widget.memberdetails.memberDetails!.youtubeLink
                            .toString() !=
                        "")
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: SocialLinks(socialLinks: socialLinks[2]),
                      ),
                    if (widget.memberdetails.memberDetails!.twitterLink
                            .toString() !=
                        "")
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: SocialLinks(socialLinks: socialLinks[3]),
                      ),
                    if (widget.memberdetails.memberDetails!.linkedinLink
                            .toString() !=
                        "")
                      Padding(
                        padding: EdgeInsets.only(right: 0.w),
                        child: SocialLinks(socialLinks: socialLinks[4]),
                      )
                  ]
                  //     List.generate(socialLinks.length, (index) {
                  //   return Padding(
                  //     padding: EdgeInsets.only(
                  //         left: index == 0 ? 0 : 20.w),
                  //     child: SocialLinks(
                  //         socialLinks: socialLinks[index]),
                  //   );
                  // }),
                  ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text("Notes", style: Theme.of(context).textTheme.headlineMedium!),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "${widget.memberdetails.memberDetails!.notes.toString()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: 26.h,
            ),
          ],
        ),
      ),
    );
  }
}
