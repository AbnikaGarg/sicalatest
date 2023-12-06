import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/theme/theme.dart';
import 'package:sica/views/profile/add_project.dart';
import '../../components/movie_card.dart';

class FilmsTab extends StatefulWidget {
  const FilmsTab({super.key, required this.memberdetails});
  final MemberBasicDetails memberdetails;

  @override
  State<FilmsTab> createState() => _nameState();
}

class _nameState extends State<FilmsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ( widget.memberdetails.works!.length != 0)
          Expanded(
            child: ListView.builder(
              itemCount:widget.memberdetails.works!.length,
             
              padding: EdgeInsets.zero,
             
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.memberdetails.works![index].projectName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "${widget.memberdetails.works![index].designation}",
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                         
                          Text(
                            "${widget.memberdetails.works![index].year}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 12.sp,
                                    color: Theme.of(context).iconTheme.color),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        else
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "No Work",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(
                          fontSize: 14.sp,
                          color: AppTheme.whiteBackgroundColor),
                ),
              ],
            ),
          )
      ],
    );
  }
}
