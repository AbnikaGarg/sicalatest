import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/views/members/components/members_tabbar.dart';

import '../../components/member_card.dart';
import '../../models/JobProviderModel.dart';
import '../../theme/theme.dart';
import '../../utils/images.dart';
import 'add_provider.dart';

class JobProvidersDetails extends StatefulWidget {
  const JobProvidersDetails({super.key, required this.jobProvider});
  final JobProviderDetails jobProvider;

  @override
  State<JobProvidersDetails> createState() => _nameState();
}

class _nameState extends State<JobProvidersDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: false,
          elevation: 0,
          title:  Text("${widget.jobProvider.designation}"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: AppTheme.bodyTextColor,
                )),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => MembersTabBar()));
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.3), width: 1)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${widget.jobProvider.jobsProvider!.memberName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${widget.jobProvider.jobsProvider!.designation}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                 
                                  
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          RichText(
                            textScaleFactor: 1,
                            text: TextSpan(
                              text: '#',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: 14.sp,
                                      color: Theme.of(context).primaryColor),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' ${widget.jobProvider.jobsProvider!.membershipNo}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.hintTextColor)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ));
  }
}
