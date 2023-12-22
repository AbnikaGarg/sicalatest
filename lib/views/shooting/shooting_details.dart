import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/components/input_feild.dart';
import 'package:sica/models/DopApprovalModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/events/event_book.dart';
import 'package:sica/views/home/dashboard.dart';

import '../../components/buton.dart';
import '../../theme/theme.dart';

class ShootingDopApproval extends StatefulWidget {
  const ShootingDopApproval({super.key});

  @override
  State<ShootingDopApproval> createState() => _ShootingDopApprovalState();
}

class _ShootingDopApprovalState extends State<ShootingDopApproval> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  bool isShow = false;
  List<DopApprovalModel>? dopList;
  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isShow = prefs.getBool("buttonlicked") ?? false;
    setState(() {});
    final service = MemberRepo();
    service.getApprovalService().then((value) {
      if (value.isNotEmpty) {
        dopList = value;
        print("loaded");

        if (mounted) setState(() {});
      }
    });
  }

  final reason = TextEditingController();
  submit(status) {
    final service = MemberRepo();
    DialogHelp.showLoading(context);
    service
        .updateApprovalService(
            dopList!.first.dopAssociateAllDetails!.first.shootingDopDetails!
                .shootingDopId
                .toString(),
            dopList!.first.dopAssociateAllDetails!.first.associate!.first
                .associateId
                .toString(),
            status,
            reason.text)
        .then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Shooting DOP updated",
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MyDashBoard(currentIndex: 0)),
            (_) => false);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
    });
  }

  showDialogSubmit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
          insetPadding: EdgeInsets.symmetric(horizontal: 36.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Are you sure you not attend this Shooting",
                style: GoogleFonts.roboto(
                    decoration: TextDecoration.none,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.whiteBackgroundColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 26.h),
              Container(
                child: MyTextField(
                    textEditingController: reason,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Reason";
                      }
                      return null;
                    },
                    hintText: "Reason",
                    color: const Color(0xff585A60)),
              ),
              SizedBox(height: 26.h),
              //Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 110.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppTheme.backGround2),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                        ),
                        child: Center(
                          child: Text(
                            "CANCEL",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 14.sp,
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      submit(false);
                    },
                    child: Container(
                      width: 110.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Text(
                            "SUBMIT",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                                fontSize: 14.sp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  //var events;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: !isShow
          ? Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: RoundedButton(
                            height: 40,
                            textcolor: Color.fromARGB(255, 0, 0, 0),
                            title: "Attending",
                            ontap: () async {
                                 setState(() {
                                isShow=true;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("buttonlicked", true);
                              Fluttertoast.showToast(
                                  msg: "Shooting DOP updated",
                                  backgroundColor: Colors.green,
                                  gravity: ToastGravity.CENTER,
                                  textColor: Colors.white);
                              //  submit(true);
                            },
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: RoundedButton(
                            height: 40,
                            textcolor: Color.fromARGB(255, 236, 236, 236),
                            title: "Not Attending",
                            ontap: () async {
                              setState(() {
                                isShow=true;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("buttonlicked", true);
                              Fluttertoast.showToast(
                                  msg: "Shooting DOP updated",
                                  backgroundColor: Colors.green,
                                  gravity: ToastGravity.CENTER,
                                  textColor: Colors.white);
                              //  showDialogSubmit();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => EventBook(),
                              //   ),
                              // );
                            },
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  )
                ],
              ),
            )
          : Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
            ),
      body: dopList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.asset(
                            "assets/images/banner3.png",
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.dstATop,
                          ),
                        ),
                        Positioned(
                            top: height + 5,
                            left: 10,
                            right: 10,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: AppTheme.whiteBackgroundColor),
                                ),
                                Expanded(
                                  child: Text(
                                    "  ${dopList!.first.dopAssociateAllDetails!.first.shootingDopDetails!.projectTitle}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            color:
                                                AppTheme.whiteBackgroundColor,
                                            fontSize: 20.sp),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Icon(Icons.share, color: AppTheme.darkTextColor),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${dopList!.first.dopAssociateAllDetails!.first.shootingDopDetails!.projectTitle}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "${dopList!.first.dopAssociateAllDetails!.first.shootingDopDetails!.designation} |  ${dopList!.first.dopAssociateAllDetails!.first.shootingDopDetails!.startDate}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: 10.w,
                              // ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     color: Theme.of(context).primaryColor,
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(5),
                              //     child: Text(
                              //       "Movie",
                              //       style: GoogleFonts.inter(
                              //           fontSize: 12.sp,
                              //           fontWeight: FontWeight.w500,
                              //           color: AppTheme.bodyTextColor),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.headlineMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${dopList!.first.dopAssociateAllDetails!.first.shootingDopDetails!.shootingNote}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    )
                  ])),
    );
  }
}
