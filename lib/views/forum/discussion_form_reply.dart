import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/models/TopicModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sica/services/forum_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';

// ignore: must_be_immutable
class DiscussionFormReply extends StatefulWidget {
  DiscussionFormReply({super.key, required this.discussionTopicComments});
  final DiscussionForumDetails discussionTopicComments;
  @override
  State<DiscussionFormReply> createState() => _nameState();
}

class _nameState extends State<DiscussionFormReply> {
  final commentText = TextEditingController();
  bool istype = false;
  @override
  void initState() {
    super.initState();

    getTopics();
  }

  _launchURL(url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launh';
        }
      }
    } else {
      url = url;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  String commentid = "";
  String getYouTubeUrl(String content) {
    RegExp regExp = RegExp(
        r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?');
    String? matches = regExp.stringMatch(content);
    if (matches == null) {
      return ''; // Always returns here while the video URL is in the content paramter
    }
    final String youTubeUrl = matches;
    return youTubeUrl;
  }

  pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }
  }

  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    // if (!url.contains("http") && (url.length == 11)) return url;
    print(url);
    // if (trimWhitespaces) url = url.trim();
    RegExp regExp = RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$");
    RegExp regExp2 =
        RegExp(r"^https:\/\/(?:www\.|m\.)?youtu.be\/([_\-a-zA-Z0-9]{11}).*$");
    // for (var exp in [
    //   RegExp(
    //       r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),

    // ]) {
    Iterable<Match>? matches = regExp.allMatches(getYouTubeUrl(url));

    //  if (matches.isNotEmpty) {
    for (Match match in matches) {
      return match.group(1);

      //   }
      // && match.first.groupCount >= 1

      //}
    }

    return null;
  }

  getyoutubelink(url) {
    String? videoId = convertUrlToId(url);
    String thumbnailUrl = getThumbnail(videoId: videoId ?? "");
    print(thumbnailUrl);
    return videoId == null ? "" : thumbnailUrl;
  }

  String getThumbnail({
    required String videoId,
    String quality = "sddefault",
    bool webp = true,
  }) =>
      webp
          ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
          : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';
  List<TopicModel>? topicList;
  DiscussionForumDetails? discussionTopicCommentsList;
  void getTopics() {
    final service = Forum();
    textTopic.text = widget.discussionTopicComments.discussionDetails!.topic!;
    service
        .getTopicList(
            widget.discussionTopicComments.discussionDetails!.categoryId)
        .then((value) {
      if (value.isNotEmpty) {
        topicList = value;
        List<DiscussionForumDetails> aa = value.first.discussionForumDetails!
            .where((element) =>
                element.discussionDetails!.discussionId.toString() ==
                widget.discussionTopicComments.discussionDetails!.discussionId
                    .toString())
            .toList();
        discussionTopicCommentsList = aa[0];
        if (mounted) setState(() {});
      }
    });
  }

  void submit() {
    // if (formKey.currentState!.validate()) {
    final service = Forum();
    DialogHelp.showLoading(context);
    service
        .createCommment(commentText.text,
            widget.discussionTopicComments.discussionDetails!.discussionId!)
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
          commentText.clear();
          Fluttertoast.showToast(
              msg: "Comment Added Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          // Navigator.of(context).pop();
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

  void updatesubmit() {
    // if (formKey.currentState!.validate()) {
    final service = Forum();
    DialogHelp.showLoading(context);
    service
        .updateCommment(commentText.text, int.parse(commentid))
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
          commentText.clear();
          commentid="";
          setState(() {
            
          });
          Fluttertoast.showToast(
              msg: "Comment Updated Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          // Navigator.of(context).pop();
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

  void deleteTopic() {
    // if (formKey.currentState!.validate()) {
    final service = Forum();
    DialogHelp.showLoading(context);
    service
        .deleteTopic(
            textTopic.text,
            widget.discussionTopicComments.discussionDetails!.discussionId
                .toString())
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
          commentText.clear();
          Fluttertoast.showToast(
              msg: "Delete Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          Navigator.pop(context, true);
          Navigator.pop(context, true);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  void updateTopic() {
    if (formKey.currentState!.validate()) {
      final service = Forum();
      DialogHelp.showLoading(context);
      service
          .editTopic(
              textTopic.text,
              widget.discussionTopicComments.discussionDetails!.discussionId
                  .toString())
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
                msg: "Topic Updated Successfully",
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
            Navigator.pop(context, true);
            Navigator.pop(context, true);
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

  showDialogSubmit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    children: [
                      Text(
                        "Are you sure you want to delete this topic",
                        style: GoogleFonts.roboto(
                            decoration: TextDecoration.none,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.whiteBackgroundColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 26.h),
                      //Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppTheme.backGround2),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                ),
                                child: Center(
                                  child: Text(
                                    "CANCEL",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 14.sp,
                                          color: AppTheme.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              deleteTopic();
                            },
                            child: Container(
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Center(
                                  child: Text(
                                    "DELETE",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                        fontSize: 14.sp,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    Navigator.pop(context, true);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Icon(Icons.arrow_back_ios)),
          title: const Text("Comments"),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         showModal(context);
          //       },
          //       icon: const Icon(
          //         Icons.edit,
          //         // color: AppTheme.bodyTextColor,
          //       )),
          //   IconButton(
          //       onPressed: () {
          //         showDialogSubmit();
          //       },
          //       icon: const Icon(
          //         Icons.delete,
          //         // color: AppTheme.bodyTextColor,
          //       ))
          // ],
        ),
        body: discussionTopicCommentsList == null
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 16,
                  color: Colors.yellow,
                ),
              )
            : Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // if (widget.discussionTopicComments.discussionDetails!
                        //         .last_commit_member_image !=
                        //     "")
                        //   CachedNetworkImage(
                        //     height: 36.h,
                        //     width: 36.h,
                        //     imageUrl: widget.discussionTopicComments
                        //         .discussionDetails!.last_commit_member_image
                        //         .toString(),
                        //     imageBuilder: (context, imageProvider) => Container(
                        //       decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           image: DecorationImage(
                        //             image: imageProvider,
                        //             fit: BoxFit.cover,
                        //           )),
                        //     ),
                        //     placeholder: (context, url) => SizedBox(
                        //       child: Center(
                        //           child: const CircularProgressIndicator(
                        //         color: Colors.yellow,
                        //       )),
                        //       height: 10.h,
                        //       width: 10.h,
                        //     ),
                        //     errorWidget: (context, url, error) =>
                        //         Icon(Icons.error),
                        //   )
                        // else
                        //   Container(
                        //   height: 36.h,
                        //     width: 36.h,
                        //     decoration: const BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //         image: AssetImage("assets/images/profile.jpeg"),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    widget.discussionTopicComments
                                        .discussionDetails!.topic
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                // SizedBox(
                                //   height: 6.h,
                                // ),
                                //  if(topicList!.first.discussionForumDetails![index].discussionDetails!.last_member_name.toString()!="false")
                                //             SizedBox(
                                //               height: 6.h,
                                //             ),
                                //             if(topicList!.first.discussionForumDetails![index].discussionDetails!.last_member_name.toString()!="false")
                                //             Text(
                                //               "${topicList!.first.discussionForumDetails![index].discussionDetails!.last_member_name.toString()} | ${topicList!.first.discussionForumDetails![index].discussionDetails!.last_topic_create_date.toString()}",
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .bodySmall!
                                //                   .copyWith(fontSize: 14),
                                //             ),
                                // Text(
                                //   "${widget.discussionTopicComments.discussionDetails!.last_member_name.toString()} | ${widget.discussionTopicComments.discussionDetails!.last_topic_create_date.toString()}",
                                //   style: Theme.of(context).textTheme.displaySmall,
                                // ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "Created by: ${widget.discussionTopicComments.discussionDetails!.memberName.toString()} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: AppTheme.hintTextColor),
                                ),
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
                              " ${discussionTopicCommentsList!.discussionComments!.length.toString()}",
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
                  Divider(color: AppTheme.backGround2, thickness: 0.2),
                  if (discussionTopicCommentsList!
                      .discussionComments!.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        // outer ListView
                        /// shrinkWrap: true, // 1st add
                        // primary: false, // 2nd add
                        itemCount: discussionTopicCommentsList!
                            .discussionComments!.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 10.h),
                            child: Slidable(
                              key: const ValueKey(0),
                              enabled: true,
                              // The start action pane is the one at the left or the top side.
                              endActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                // A pane can dismiss the Slidable.

                                extentRatio: 0.5,
                                // All actions are defined in the children parameter.
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: (context) {
                                      setState(() {
                                        commentText.text =
                                            discussionTopicCommentsList!
                                                .discussionComments![index]
                                                .comment
                                                .toString();
                                        commentid = discussionTopicCommentsList!
                                            .discussionComments![index]
                                            .commentId
                                            .toString();
                                      });
                                    },
                                    backgroundColor: AppTheme.darkTextColor,
                                    foregroundColor:
                                        AppTheme.whiteBackgroundColor,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (discussionTopicCommentsList!
                                            .discussionComments![index]
                                            .profileImage
                                            .toString() !=
                                        "")
                                      CachedNetworkImage(
                                        height: 36.h,
                                        width: 36.h,
                                        imageUrl: discussionTopicCommentsList!
                                            .discussionComments![index]
                                            .profileImage
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
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    discussionTopicCommentsList!
                                                        .discussionComments![
                                                            index]
                                                        .memberName
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                            fontSize: 14)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Linkify(
                                            options:
                                                LinkifyOptions(humanize: false),
                                            onOpen: (link) async {
                                              if (!await launchUrl(
                                                  Uri.parse(link.url))) {
                                                throw Exception(
                                                    'Could not launch ${link.url}');
                                              }
                                            },
                                            text: discussionTopicCommentsList!
                                                .discussionComments![index]
                                                .comment
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(fontSize: 14),
                                            linkStyle:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     _launchURL(getYouTubeUrl(
                                          //         discussionTopicCommentsList!
                                          //             .discussionComments![
                                          //                 index]
                                          //             .comment
                                          //             .toString()));
                                          //   },
                                          //   child: Text(
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodySmall!,
                                          //     discussionTopicCommentsList!
                                          //         .discussionComments![index]
                                          //         .comment
                                          //         .toString(),
                                          //   ),
                                          // ),
                                          if (getyoutubelink(
                                                discussionTopicCommentsList!
                                                    .discussionComments![index]
                                                    .comment
                                                    .toString(),
                                              ) !=
                                              "")
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                          if (getyoutubelink(
                                                discussionTopicCommentsList!
                                                    .discussionComments![index]
                                                    .comment
                                                    .toString(),
                                              ) !=
                                              "")
                                            Stack(
                                              children: [
                                                Image.network(
                                                  getyoutubelink(
                                                    discussionTopicCommentsList!
                                                        .discussionComments![
                                                            index]
                                                        .comment
                                                        .toString(),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  height: 200,
                                                  width: 300,
                                                ),
                                                Positioned(
                                                  top: 14,
                                                  left: 10,
                                                  child: Text(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                    "Click above link for open youtube",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          // SizedBox(
                                          //   height: 16.h,
                                          // ),
                                          // ListView.builder(
                                          //   // inner ListView
                                          //   shrinkWrap: true, // 1st add
                                          //   physics: ClampingScrollPhysics(), // 2nd add
                                          //   itemCount: 2,
                                          //   itemBuilder: (_, index) => Padding(
                                          //     padding: EdgeInsets.only(
                                          //         left: 30.w, bottom: 10.h, top: 10.h),
                                          //     child: Container(
                                          //       padding: EdgeInsets.symmetric(
                                          //           horizontal: 10.w, vertical: 8.h),
                                          //       decoration: BoxDecoration(
                                          //           borderRadius: BorderRadius.circular(8),
                                          //           color: Theme.of(context).cardColor,
                                          //           border: Border.all(
                                          //               color: Colors.grey.withOpacity(0.3),
                                          //               width: 1)),
                                          //       child: Column(
                                          //         children: [
                                          //           Row(
                                          //             crossAxisAlignment:
                                          //                 CrossAxisAlignment.center,
                                          //             children: [
                                          //               Container(
                                          //                 height: 30.h,
                                          //                 width: 30.h,
                                          //                 decoration: BoxDecoration(
                                          //                   shape: BoxShape.circle,
                                          //                   image: DecorationImage(
                                          //                     image: AssetImage(
                                          //                         'assets/images/tie.jpg'),
                                          //                     fit: BoxFit.cover,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Expanded(
                                          //                 child: Padding(
                                          //                   padding: EdgeInsets.only(left: 8.w),
                                          //                   child: Text("Vimal",
                                          //                       style: Theme.of(context)
                                          //                           .textTheme
                                          //                           .headlineMedium!),
                                          //                 ),
                                          //               ),
                                          //               SizedBox(
                                          //                 width: 10.w,
                                          //               ),
                                          //               Text(
                                          //                 "2 mints ago",
                                          //                 style: TextStyle(fontSize: 12.sp),
                                          //               )
                                          //             ],
                                          //           ),
                                          //           SizedBox(
                                          //             height: 8.h,
                                          //           ),
                                          //           Text(
                                          //             style:
                                          //                 Theme.of(context).textTheme.bodySmall!,
                                          //             "Here i’m studying B. Sc. Statistics this is my final year. I liked this college because i learned to my life. The staffs from my department ",
                                          //           )
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Expanded(
                      child: const Center(
                        child: Text('No Comments yet'),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8, bottom: 12.h, right: 14.w, top: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   child: MyTextField(

                        //       textEditingController: commentText,
                        //       labelText: "",
                        //       float: FloatingLabelBehavior.always,
                        //       hintText: "Add Comment",
                        //       color: const Color(0xff585A60)),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: GestureDetector(
                            onTap: () {
                              pickFiles();
                            },
                            child: Icon(
                              Icons.attach_file,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 25.0,
                              maxHeight: 135.0,
                            ),
                            child: Scrollbar(
                              child: TextField(
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: TextStyle(
                                    color: AppTheme.whiteBackgroundColor),
                                controller: commentText,
                                maxLength: 1000,
                                //   _handleSubmitted : null,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.whiteBackgroundColor),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                      borderSide: BorderSide(
                                          color: AppTheme.backGround)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                      borderSide: BorderSide(
                                          color: AppTheme.backGround)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                      borderSide: BorderSide(
                                          color: AppTheme.backGround)),
                                  contentPadding: EdgeInsets.only(
                                      top: 2.0,
                                      left: 13.0,
                                      right: 13.0,
                                      bottom: 2.0),
                                  hintText: "Type your comment",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            if (commentText.text.isNotEmpty) {
                              if (commentid != '') {
                                updatesubmit();
                              } else {
                                submit();
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(37, 40, 54, 0.6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              child: Text(
                                "Post",
                                style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'All';
  List _topictype = ["All", "Member", "Guest"];
  final textTopic = TextEditingController();
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
                                    "Edit Topic",
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
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.h, bottom: 20.h, left: 10, right: 10),
                              child: RoundedButton(
                                ontap: () {
                                  updateTopic();
                                },
                                textcolor: Color.fromARGB(255, 14, 13, 13),
                                title: "Update",
                                height: 40,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ]),
                    ),
                  ),
                ),
              ));
        });
  }
}
