import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/components/input_feild.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import '../../components/buton.dart';
import '../../theme/theme.dart';
import '../../utils/images.dart';
import 'discussion_form_reply.dart';

class DiscussionForm extends StatefulWidget {
  const DiscussionForm({super.key});

  @override
  State<DiscussionForm> createState() => _nameState();
}

class _nameState extends State<DiscussionForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          title: Text("Discussion forum"),
          actions: [
            IconButton(
                onPressed: () {
                  showModal(context);
                },
                icon: Icon(
                  Icons.add,
                  color: AppTheme.bodyTextColor,
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DiscussionFormReply()));
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "Sam | 02 Feb '12 | 9:00 pm",
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
                  ),
                );
              },
            ))
          ],
        ));
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
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                                  onTap: () {Navigator.of(context).pop();},
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
                              title: "Create",
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
