import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/models/DopModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/shooting/create_dop.dart';
import 'package:sica/views/shooting/dop_details.dart';

class DOPList extends StatefulWidget {
  const DOPList({super.key});

  @override
  State<DOPList> createState() => _nameState();
}

class _nameState extends State<DOPList> {
  @override
  void initState() {
    super.initState();
    getDopList();
  }

  List<DopModel>? dopList;
  void getDopList() {
    final service = MemberRepo();
    service.getDops(10).then((value) {
      if (value.isNotEmpty) {
        dopList = value;

        if (mounted) setState(() {});
      }
    });
  }

  Future<bool> onWillPop() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MyDashBoard(currentIndex: 0)),
        (_) => false);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 12,
            elevation: 1,
            leading: GestureDetector(
                onTap: () {
                  onWillPop();
                },
                child: Icon(Icons.arrow_back_ios)),
            title: const Text("DOP"),
            actions: [
              IconButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const CreateDOP()));
                  },
                  icon: const Icon(
                    Icons.add,
                    // color: AppTheme.bodyTextColor,
                  ))
            ],
          ),
          body: dopList == null
              ? const Center(
                  child: CupertinoActivityIndicator(
                    radius: 16,
                    color: Colors.yellow,
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    if (dopList!.first.shootingDopAllDetails!.isNotEmpty)
                      Expanded(
                          child: ListView.builder(
                        itemCount: dopList!.first.shootingDopAllDetails!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DopDetails(
                                        shootingdetials: dopList!.first
                                            .shootingDopAllDetails![index],
                                      )));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 8.h),
                              child: GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).cardColor,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 1)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  dopList!
                                                      .first
                                                      .shootingDopAllDetails![
                                                          index]
                                                      .shootingDopDetails!
                                                      .projectTitle
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium!),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Text(
                                                "${dopList!.first.shootingDopAllDetails![index].shootingDopDetails!.memberName.toString()} | ${dopList!.first.shootingDopAllDetails![index].shootingDopDetails!.mobileNumber.toString()}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.tag,
                                            size: 16.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text(
                                              " ${dopList!.first.shootingDopAllDetails![index].shootingDopDetails!.memberNumber.toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                    height: 0,
                                                    fontSize: 14.sp,
                                                  ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ))
                    else
                      Expanded(
                        child: const Center(
                          child: Text('No  Records'),
                        ),
                      )
                  ],
                )),
    );
  }
}
