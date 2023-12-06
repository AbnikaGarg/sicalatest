
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/models/PaymentResponse.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/profile/add_project.dart';
import 'package:sica/views/profile/add_work.dart';
import 'package:sica/views/profile/edit_profile.dart';
import 'package:sica/views/profile/payment.dart';

import '../../components/movie_card.dart';
import '../../theme/theme.dart';
import 'add_socialsLinks.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List socialLinks = [
    {"image": "facebook.png", "title": "Facebook"},
    {"image": "insta.png", "title": "Insta"},
    {"image": "youtube.png", "title": "youtube"},
    {"image": "twiter.png", "title": "twiter"},
    {"image": "linkedin.png", "title": "linkedin"}
  ];

  List<MemberDetailModel>? memberDetails;

  @override
  void initState() {
    super.initState();
    getMemberDetails();
  }

  String? accountType;
  void getMemberDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accountType = (sharedPreferences.getString('accounttype') ?? "");
    if (mounted) setState(() {});
    final service = MemberRepo();
    service.getMemberDetails().then((value) {
      if (value.isNotEmpty) {
        memberDetails = value;
        if (mounted) setState(() {});
      }
    });
  }

  void createPayment() {
    final service = MemberRepo();
    DialogHelp.showLoading(context);
    service.createPayment().then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        List<PaymentResponse> res = value;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MakePayment(
                  url: res[0].paymentlink!.shortUrl.toString(),
                  callBackurl:res[0].paymentlink!.callbackUrl.toString()
                )));
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppTheme.backGround2,
      appBar: AppBar(
        titleSpacing: 12,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Text("Profile"),
        actions: [
          if (accountType == "1")
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProfile(
                            details: memberDetails![0].memberBasicDetails!,
                          )));
                },
                icon: Icon(
                  Icons.edit,
                  // color: AppTheme.bodyTextColor,
                ))
        ],
      ),
      body: accountType == "1"
          ? memberDetails != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (memberDetails![0]
                                    .memberBasicDetails!
                                    .image
                                    .toString() ==
                                "")
                              Container(
                                height: 80.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/profile.jpeg'),
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
                                    image: NetworkImage(memberDetails![0]
                                        .memberBasicDetails!
                                        .image
                                        .toString()),
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
                                        memberDetails![0]
                                            .memberBasicDetails!
                                            .name
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      memberDetails![0]
                                          .memberBasicDetails!
                                          .designation
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
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
                                text: ' #',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontSize: 18.sp,
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '  ${memberDetails![0].memberBasicDetails!.membershipNo.toString()}',
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
                                    ' ${memberDetails![0].memberBasicDetails!.joiningDate.toString()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontSize: 14.sp,
                                        )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text("Skills",
                            style: Theme.of(context).textTheme.headlineMedium!),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          "${memberDetails![0].memberBasicDetails!.skills.toString()}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text("Medium",
                            style: Theme.of(context).textTheme.headlineMedium!),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          "${memberDetails![0].memberBasicDetails!.medium.toString()}",
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
                          "${memberDetails![0].memberBasicDetails!.portifolioLink.toString()}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Socials Link",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SocialLinksPage(
                                          facebook: memberDetails![0]
                                              .memberBasicDetails!
                                              .facebookLink
                                              .toString(),
                                          insta: memberDetails![0]
                                              .memberBasicDetails!
                                              .instagramLink
                                              .toString(),
                                          linkedin: memberDetails![0]
                                              .memberBasicDetails!
                                              .linkedinLink
                                              .toString(),
                                          twiter: memberDetails![0]
                                              .memberBasicDetails!
                                              .twitterLink
                                              .toString(),
                                          youtube: memberDetails![0]
                                              .memberBasicDetails!
                                              .youtubeLink
                                              .toString(),
                                        )));
                              },
                              child: Text("+Add",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!),
                            ),
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
                                if (memberDetails![0]
                                        .memberBasicDetails!
                                        .facebookLink
                                        .toString() !=
                                    "")
                                  Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: SocialLinks(
                                        socialLinks: socialLinks[0]),
                                  ),
                                if (memberDetails![0]
                                        .memberBasicDetails!
                                        .instagramLink
                                        .toString() !=
                                    "")
                                  Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: SocialLinks(
                                        socialLinks: socialLinks[1]),
                                  ),
                                if (memberDetails![0]
                                        .memberBasicDetails!
                                        .youtubeLink
                                        .toString() !=
                                    "")
                                  Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: SocialLinks(
                                        socialLinks: socialLinks[2]),
                                  ),
                                if (memberDetails![0]
                                        .memberBasicDetails!
                                        .twitterLink
                                        .toString() !=
                                    "")
                                  Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: SocialLinks(
                                        socialLinks: socialLinks[3]),
                                  ),
                                if (memberDetails![0]
                                        .memberBasicDetails!
                                        .linkedinLink
                                        .toString() !=
                                    "")
                                  Padding(
                                    padding: EdgeInsets.only(right: 0.w),
                                    child: SocialLinks(
                                        socialLinks: socialLinks[4]),
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
                        Text("Notes",
                            style: Theme.of(context).textTheme.headlineMedium!),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          "${memberDetails![0].memberBasicDetails!.notes.toString()}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              createPayment();
                            },
                            child: Text(
                              "Membership ends in 14 days. Click here to Renew",
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Works",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!),
                            if (memberDetails![0].projectWork!.length != 0)
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => AddProject(
                                                  projectList: ProjectWork(),
                                                )));
                                  },
                                  child: Icon(Icons.add))
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (memberDetails![0].projectWork!.length != 0)
                          Divider(
                            color: AppTheme.hintTextColor,
                          ),
                        if (memberDetails![0].projectWork!.length != 0)
                          ListView.builder(
                            itemCount: memberDetails![0].projectWork!.length,
                            primary: false,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${memberDetails![0].projectWork![index].projectName}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(fontSize: 15.sp),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            "${memberDetails![0].projectWork![index].designation}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          //  behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddProject(
                                                            projectList:
                                                                memberDetails![
                                                                            0]
                                                                        .projectWork![
                                                                    index])));
                                          },
                                          child: Icon(Icons.edit,
                                              size: 17.sp, color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "${memberDetails![0].projectWork![index].year}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontSize: 12.sp,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        else
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddProject(
                                            projectList: ProjectWork(),
                                          )));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/addwork.png",
                                      height: 40.h,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Add Work",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontSize: 14.sp,
                                              color: AppTheme
                                                  .whiteBackgroundColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80.h,
                          width: 80.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/profile.jpeg'),
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
                                Text("Guest Name",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "Guest Designation",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
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
                            text: ' #',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontSize: 18.sp,
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '  2',
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
                            Text(' 23-08-2023',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontSize: 14.sp,
                                    )),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text("Skills",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "Fluter Java",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text("Medium",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "------",
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
                      "www.sica.com",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class SocialLinks extends StatelessWidget {
  SocialLinks({
    super.key,
    this.socialLinks,
  });

  var socialLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/${socialLinks["image"]}"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          socialLinks["title"],
          style:
              Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12.sp),
        )
      ],
    );
  }
}
