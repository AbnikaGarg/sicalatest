import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/views/events/event_book.dart';

import '../../components/buton.dart';
import '../../theme/theme.dart';

class EventDetail extends StatelessWidget {

 EventDetail({
    required this.events,
    super.key,
  });
 var events;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RoundedButton(
          textcolor: Color.fromARGB(255, 0, 0, 0),
          title: "Enroll",
          ontap: (){
             Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventBook(),
          ),
        );
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
                    events["image"].toString(),
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
                            color: AppTheme.darkTextColor),
                        Expanded(
                          child: Text(
                            "  ${events["title"].toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color: AppTheme.darkTextColor,
                                    fontSize: 20.sp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.share, color: AppTheme.darkTextColor),
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
                      SvgPicture.asset("assets/icons/callender.svg"),
                      Expanded(
                        child: Text(
                          " ${events["date"].toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            "Workshop",
                            style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: AppTheme.whiteBackgroundColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/clock.svg"),
                      Text(
                       " ${events["duration"].toString()}",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(fontSize: 12.sp),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/reel.svg"),
                      Expanded(
                        child: Text(
                         " ${events["author"].toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ],
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
