import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/views/events/event_book.dart';

import '../../components/buton.dart';
import '../../theme/theme.dart';

class ShootingDetail extends StatelessWidget {
  ShootingDetail({
    // required this.events,
    super.key,
  });
  //var events;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RoundedButton(
          textcolor: Color.fromARGB(255, 0, 0, 0),
          title: "Attending",
          ontap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => EventBook(),
            //   ),
            // );
          },
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        Icon(Icons.arrow_back,
                            color: AppTheme.whiteBackgroundColor),
                        Expanded(
                          child: Text(
                            "  Vacation",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color: AppTheme.whiteBackgroundColor,
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
                            Text("Vacation",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              "Venkat Pradbhu | 11 Feb '12",
                              style: Theme.of(context).textTheme.displaySmall,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Movie",
                            style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.bodyTextColor),
                          ),
                        ),
                      ),
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
                    "Lorem ipsum dolor sit amet. Ut suscipit  of amet explicabeo et voluptatem landandtium amd amet explicabeo et voluptatem Lorem ipsum dolor sit amet. Ut suscipit  of amet explicabeo et amd voluptatem landandtium amd amet explicabeo et voluptatem see more...",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
