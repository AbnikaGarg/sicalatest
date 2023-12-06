import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sica/models/JobProviderModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/employeement_schema/add_provider.dart';
import 'package:sica/views/vendors/vendors_details.dart';

import 'job_provider_details.dart';

class JobProviders extends StatefulWidget {
  const JobProviders({super.key});

  @override
  State<JobProviders> createState() => _nameState();
}

class _nameState extends State<JobProviders> {
  @override
  void initState() {
    super.initState();
    getJobProvidersList();
  }

  List<JobProviderModel>? jobProviderRes;
  void getJobProvidersList() {
    final service = MemberRepo();
    service.getJobProviders().then((value) {
      if (value.isNotEmpty) {
        jobProviderRes = value;

        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: const Text("Job Provider"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProvider(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.add,
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            if (jobProviderRes != null)
              if (jobProviderRes![0].jobProviderDetails!.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                  itemCount: jobProviderRes![0].jobProviderDetails!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  JobProvidersDetails(jobProvider: jobProviderRes![0].jobProviderDetails![index],)));
                      },
                      child: ProviderCard(
                        index: index+6,
                          title: jobProviderRes![0]
                              .jobProviderDetails![index]
                              .designation
                              .toString()),
                    );
                  },
                ))
          ],
        ));
  }
}

class ProviderCard extends StatelessWidget {
  const ProviderCard({
    super.key,
    required this.title, required this.index,
  });
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(title,
                  style: Theme.of(context).textTheme.headlineMedium!),
            ),
            SizedBox(
              width: 10.w,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/employement.svg",
                  color: Theme.of(context).primaryColor,
                  height: 20,
                ),
                Text(' $index',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 14.sp,
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
