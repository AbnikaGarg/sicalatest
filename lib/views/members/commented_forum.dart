import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../forum/discussion_form_reply.dart';

class DiscussionCommented extends StatefulWidget {
  const DiscussionCommented({super.key});

  @override
  State<DiscussionCommented> createState() => _nameState();
}

class _nameState extends State<DiscussionCommented> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 20.h,
        ),
        ListView.builder(
          itemCount: 2,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DiscussionFormReply()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.3), width: 1)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration:const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/tie.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("How did today's shoot wents",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                "Sam | 02 Feb '12 | 9:00 pm",
                                style:
                                    Theme.of(context).textTheme.displaySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.insert_comment_outlined,
                            size: 16.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            " 2",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontSize: 14.sp,
                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ]),
    );
  }
}
