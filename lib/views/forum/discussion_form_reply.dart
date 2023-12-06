import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';

class DiscussionFormReply extends StatefulWidget {
  const DiscussionFormReply({super.key});

  @override
  State<DiscussionFormReply> createState() => _nameState();
}

class _nameState extends State<DiscussionFormReply> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title:const Text("Discussion forum"),
        actions: [
          IconButton(
              onPressed: () {
                showModal(context);
              },
              icon:const Icon(
                Icons.edit,
               // color: AppTheme.bodyTextColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
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
                              style:
                                  Theme.of(context).textTheme.headlineMedium!),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "Sam | 02 Feb '12 | 9:00 pm",
                            style: Theme.of(context).textTheme.displaySmall,
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
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 14.sp,
                                ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              // outer ListView
              shrinkWrap: true, // 1st add
              primary: false, // 2nd add
              itemCount: 4,
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.3), width: 1)),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 30.h,
                              width: 30.h,
                              decoration: BoxDecoration(
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
                                child: Text("Vimal",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "2 mints ago  ",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                Icon(
                                  Icons.insert_comment_outlined,
                                  size: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  " 2",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontSize: 12.sp,
                                      ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          style: Theme.of(context).textTheme.bodySmall!,
                          "Here i’m studying B. Sc. Statistics this is my final year. I liked this college because i learned to my life. The staffs from my department ",
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ListView.builder(
                          // inner ListView
                          shrinkWrap: true, // 1st add
                          physics: ClampingScrollPhysics(), // 2nd add
                          itemCount: 2,
                          itemBuilder: (_, index) => Padding(
                            padding: EdgeInsets.only(
                                left: 30.w, bottom: 10.h, top: 10.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1)),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30.h,
                                        width: 30.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/tie.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8.w),
                                          child: Text("Vimal",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "2 mints ago",
                                        style: TextStyle(fontSize: 12.sp),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    style:
                                        Theme.of(context).textTheme.bodySmall!,
                                    "Here i’m studying B. Sc. Statistics this is my final year. I liked this college because i learned to my life. The staffs from my department ",
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'All';
  List _topictype = ["All", "Member", "Guest"];

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0.r),
                      topRight: Radius.circular(30.0.r),
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Create Topic",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontSize: 18.sp),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "cancel",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontSize: 14.sp,
                                            color: const Color.fromRGBO(
                                                18, 205, 217, 1)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          MyTextField(
                              // textEditingController: _controller.emailController,

                              hintText: "",
                              labelText: "Topic name",
                              color: const Color(0xff585A60)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Who can respond?",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          StatefulBuilder(builder:
                              (BuildContext context, StateSetter myState) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                for (int i = 0; i < _topictype.length; i++)
                                  Expanded(
                                    child: RadioListTile<String>(
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        title: Transform.translate(
                                          offset: Offset(-10, 0),
                                          child: Text(
                                            _topictype[i].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(fontSize: 14.sp),
                                          ),
                                        ),
                                        value: _topictype[i],
                                        groupValue: radioButtonItem,
                                        onChanged: (value) {
                                          myState(() {
                                            radioButtonItem = value!;
                                          });
                                        }),
                                  ),
                                // Expanded(
                                //   child: ListTile(
                                //     dense: true,
                                //     horizontalTitleGap: 0,
                                //     contentPadding: EdgeInsets.zero,
                                //     title: Text(
                                //       _topictype[i].toString(),
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .displayMedium!
                                //           .copyWith(fontSize: 14.sp),
                                //     ),
                                //     leading: Radio(
                                //       visualDensity: VisualDensity.compact,
                                //       value: _topictype[i],
                                //       groupValue: radioButtonItem,
                                //       onChanged: (value) {
                                //         myState(() {
                                //           radioButtonItem = value;
                                //         });
                                //       },
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                          }),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30.h, bottom: 20.h, left: 10, right: 10),
                            child: RoundedButton(
                              ontap: () {},
                              textcolor: Color.fromARGB(255, 14, 13, 13),
                              title: "Update",
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ]),
                  ),
                ),
              ));
        });
  }
}
