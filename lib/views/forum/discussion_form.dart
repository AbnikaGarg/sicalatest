import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/components/input_feild.dart';
import 'package:sica/models/TopicModel.dart';
import 'package:sica/services/forum_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import '../../components/buton.dart';
import '../../theme/theme.dart';
import '../../utils/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'discussion_form_reply.dart';

class DiscussionForm extends StatefulWidget {
  DiscussionForm({super.key, this.category});
  var category;

  @override
  State<DiscussionForm> createState() => _nameState();
}

class _nameState extends State<DiscussionForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTopics();
  }

  List<TopicModel>? topicList;
  void getTopics() {
    final service = Forum();
    service.getTopicList(widget.category["category_id"]).then((value) {
      if (value.isNotEmpty) {
        topicList = value;

        if (mounted) setState(() {});
      }
    });
  }


 
  void submit() {
    if (formKey.currentState!.validate()) {
      final service = Forum();
      DialogHelp.showLoading(context);
      service
          .addTopic(textTopic.text, widget.category["category_id"].toString())
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          if (value[0]['error'] != null) {
            Fluttertoast.showToast(
                msg: "Something went wrong",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          } else {
            textTopic.clear();
            Fluttertoast.showToast(
                msg: "Topic Added Successfully",
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
            Navigator.of(context).pop();
            getTopics();
          }

          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             MyDashBoard(currentIndex: 3)),
          //     (_) => false);
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text(widget.category["category_name"]),
          actions: [
            IconButton(
                onPressed: () {
                  showModal(context);
                },
                icon: const Icon(
                  Icons.add,

                  ///  color: AppTheme.bodyTextColor,
                ))
          ],
        ),
        body: topicList == null
            ? Center(
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
                  if (topicList!.first.discussionForumDetails!.isNotEmpty)
                    Expanded(
                        child: ListView.builder(
                      itemCount:
                          topicList!.first.discussionForumDetails!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DiscussionFormReply(
                                      discussionTopicComments: topicList!
                                          .first.discussionForumDetails![index],
                                    ))).then((val)=>val?getTopics():null);
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (topicList!
                                            .first
                                            .discussionForumDetails![index]
                                            .discussionDetails!
                                            .profile !=
                                        "")
                                      CachedNetworkImage(
                                        height: 36.h,
                                        width: 36.h,
                                        imageUrl: topicList!
                                            .first
                                            .discussionForumDetails![index]
                                            .discussionDetails!
                                            .profile
                                            .toString(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        placeholder: (context, url) => SizedBox(
                                          child: Center(
                                              child:
                                                  const CircularProgressIndicator(
                                            color: Colors.yellow,
                                          )),
                                          height: 10.h,
                                          width: 10.h,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    else
                                      Container(
                                        height: 50.h,
                                        width: 50.h,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/profile.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
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
                                                topicList!
                                                    .first
                                                    .discussionForumDetails![
                                                        index]
                                                    .discussionDetails!
                                                    .topic
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Text(
                                              "${topicList!.first.discussionForumDetails![index].discussionDetails!.memberName.toString()} | ${topicList!.first.discussionForumDetails![index].discussionDetails!.createDate.toString()}",
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
                                          Icons.insert_comment_outlined,
                                          size: 16.sp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            " ${topicList!.first.discussionForumDetails![index].discussionComments!.length.toString()}",
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
              ));
  }

  final textTopic = TextEditingController();
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'All';
  List _topictype = ["All", "Member", "Guest"];
  final formKey = GlobalKey<FormState>();
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
                    child: Form(
                      key: formKey,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      child: const Icon(Icons.cancel,
                                          color:
                                              Color.fromRGBO(18, 205, 217, 1))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            MyTextField(
                                textEditingController: textTopic,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Topic";
                                  }
                                  return null;
                                },
                                labelText: "",
                                float: FloatingLabelBehavior.always,
                                hintText: "Topic Title",
                                color: const Color(0xff585A60)),

                            // Text(
                            //   "Who can respond?",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headlineLarge!
                            //       .copyWith(fontSize: 14.sp),
                            // ),
                            // SizedBox(
                            //   height: 8.h,
                            // ),
                            // StatefulBuilder(builder:
                            //     (BuildContext context, StateSetter myState) {
                            //   return Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: <Widget>[
                            //       for (int i = 0; i < _topictype.length; i++)
                            //         Expanded(
                            //           child: RadioListTile<String>(
                            //               contentPadding: EdgeInsets.zero,
                            //               dense: true,
                            //               visualDensity: const VisualDensity(
                            //                   horizontal:
                            //                       VisualDensity.minimumDensity,
                            //                   vertical:
                            //                       VisualDensity.minimumDensity),
                            //               title: Transform.translate(
                            //                 offset: Offset(-10, 0),
                            //                 child: Text(
                            //                   _topictype[i].toString(),
                            //                   style: Theme.of(context)
                            //                       .textTheme
                            //                       .displayMedium!
                            //                       .copyWith(fontSize: 14.sp),
                            //                 ),
                            //               ),
                            //               value: _topictype[i],
                            //               groupValue: radioButtonItem,
                            //               onChanged: (value) {
                            //                 myState(() {
                            //                   radioButtonItem = value!;
                            //                 });
                            //               }),
                            //         ),
                            //       // Expanded(
                            //       //   child: ListTile(
                            //       //     dense: true,
                            //       //     horizontalTitleGap: 0,
                            //       //     contentPadding: EdgeInsets.zero,
                            //       //     title: Text(
                            //       //       _topictype[i].toString(),
                            //       //       style: Theme.of(context)
                            //       //           .textTheme
                            //       //           .displayMedium!
                            //       //           .copyWith(fontSize: 14.sp),
                            //       //     ),
                            //       //     leading: Radio(
                            //       //       visualDensity: VisualDensity.compact,
                            //       //       value: _topictype[i],
                            //       //       groupValue: radioButtonItem,
                            //       //       onChanged: (value) {
                            //       //         myState(() {
                            //       //           radioButtonItem = value;
                            //       //         });
                            //       //       },
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //     ],
                            //   );
                            // }),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                bottom: 30.h,
                              ),
                              child: RoundedButton(
                                ontap: () {
                                  submit();
                                },
                                textcolor: Color.fromARGB(255, 0, 0, 0),
                                title: "Create",
                                fontsize: 16,
                                height: 40,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                         
                          ]),
                    ),
                  ),
                ),
              ));
        });
  }
}
