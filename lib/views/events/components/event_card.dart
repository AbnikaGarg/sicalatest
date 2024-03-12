import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/views/events/event_details.dart';

import '../../../models/EventModel.dart';
import '../../../theme/theme.dart';

class EventCard extends StatelessWidget {
  EventCard({
    required this.events,
    super.key, required this.category,
  });
  final EventDetails events;
    final String category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetail(events: events, category: category,),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 110,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(events.image.toString())),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    // Positioned(
                    //   top: 10,
                    //   left: 5,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: const Color.fromRGBO(37, 40, 54, 0.6),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(4),
                    //       child: Text(
                    //         "Tech Talk",
                    //         style: GoogleFonts.inter(
                    //             fontSize: 12.sp,
                    //             fontWeight: FontWeight.w600,
                    //             color: AppTheme.whiteBackgroundColor),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         color: Theme.of(context).primaryColor,
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(4),
                    //         child: Text(
                    //           "Workshop",
                    //           style: GoogleFonts.inter(
                    //               fontSize: 12.sp,
                    //               color: AppTheme.whiteBackgroundColor),
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.all(4),
                    //       child: Container(
                    //           decoration: BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             color: Color.fromRGBO(104, 104, 104, 1),
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(4),
                    //             child: Icon(
                    //               Icons.more_horiz,
                    //               color: Colors.black,
                    //               size: 18.h,
                    //             ),
                    //           )),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    Text(
                      events.title.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/callender.svg",
                           color: AppTheme.whiteBackgroundColor,
                        ),
                        Text(
                          " ${events.startDate.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 12.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/clock.svg",
                         color: AppTheme.whiteBackgroundColor,
                        ),
                        Text(
                          " 2 days event",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 12.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/reel.svg",
                          color: AppTheme.whiteBackgroundColor,
                        ),
                        Expanded(
                          child: Text(
                            " ${events.coachName.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontSize: 12.sp),
                          ),
                        ),
                        // Container(
                        //   width: 1,
                        //   height: 20.sp,
                        //   color: AppTheme.lightTextColor,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                " INR ${events.amount.toString()} ",
                                style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
