import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/models/PaymentResponse.dart';
import 'package:sica/views/events/event_book.dart';

import '../../components/buton.dart';
import '../../models/EventModel.dart';
import '../../services/member_repo.dart';
import '../../theme/theme.dart';
import '../../utils/config.dart';
import '../profile/payment.dart';

class EventDetail extends StatefulWidget {
  EventDetail({
    required this.events,
    super.key,
    required this.category,
  });
  final EventDetails events;
  final String category;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  void createPayment(eventid) {
    final service = MemberRepo();
    DialogHelp.showLoading(context);
    service.createEventPayment(eventid).then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        List<PaymentResponse> res = value;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MakePayment(
                url: res[0].paymentlink!.shortUrl.toString(),
                callBackurl: res[0].paymentlink!.callbackUrl.toString())));
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
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RoundedButton(
          textcolor: Color.fromARGB(255, 0, 0, 0),
          title: "Enroll",
          ontap: () {
            createPayment(widget.events.eventId.toString());
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
                  child: Image.network(
                    widget.events.image.toString(),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,
                              color: AppTheme.whiteBackgroundColor),
                        ),
                        Expanded(
                          child: Text(
                            "  ${widget.events.title.toString()}",
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
                      SvgPicture.asset(
                        "assets/icons/callender.svg",
                        color: AppTheme.whiteBackgroundColor,
                      ),
                      Expanded(
                        child: Text(
                          " ${widget.events.startDate.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.yelloDarkColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "${widget.category}",
                            style: GoogleFonts.inter(
                                fontSize: 12.sp, color: AppTheme.blackColor),
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
                      SvgPicture.asset(
                        "assets/icons/clock.svg",
                        color: AppTheme.whiteBackgroundColor,
                      ),
                      Text(
                        "  3",
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
                      SvgPicture.asset(
                        "assets/icons/reel.svg",
                        color: AppTheme.whiteBackgroundColor,
                      ),
                      Expanded(
                        child: Text(
                          "  ${widget.events.coachName.toString()}",
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
                    "${widget.events.description.toString()}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
