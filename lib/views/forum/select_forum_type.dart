import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/services/forum_repo.dart';
import '../../theme/theme.dart';
import 'discussion_form.dart';
import 'package:cached_network_image/cached_network_image.dart';
class SelectForumType extends StatefulWidget {
  const SelectForumType({super.key});

  @override
  State<SelectForumType> createState() => _nameState();
}

class _nameState extends State<SelectForumType> {
  List forumType = [
    {"title": "MOVIES", "image": "assets/images/movie.png"},
    {"title": "PROJECTION", "image": "assets/images/projection.png"},
    {"title": "MEETING", "image": "assets/images/meeting.png"},
    {"title": "WORKSHOP", "image": "assets/images/workshop.png"}
  ];
  List? categories;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    final service = Forum();
    service.getForumCat().then((value) {
      if (value.isNotEmpty) {
        categories = value[0];
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: const Text("Discussion forum"),
        ),
        body: categories == null
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 16,
                  color: Colors.yellow,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                       child: ListView.builder(
                      itemCount:
                          categories!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DiscussionForm(
                                      category: categories![index],
                                    )));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h),
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
                                  // if (categories![index]["member_image"]
                                  //          !=
                                  //     "")
                                  //   CachedNetworkImage(
                                  //     height: 36.h,
                                  //     width: 36.h,
                                  //     imageUrl:categories![index]["member_image"],
                                  //     imageBuilder:
                                  //         (context, imageProvider) =>
                                  //             Container(
                                  //       decoration: BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //           image: DecorationImage(
                                  //             image: imageProvider,
                                  //             fit: BoxFit.cover,
                                  //           )),
                                  //     ),
                                  //     placeholder: (context, url) => SizedBox(
                                  //       child: Center(
                                  //           child:
                                  //               const CircularProgressIndicator(
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
                                  //      height: 36.h,
                                  //     width: 36.h,
                                  //     decoration: const BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       image: DecorationImage(
                                  //         image: AssetImage(
                                  //             "assets/images/profile.jpeg"),
                                  //         fit: BoxFit.cover,
                                  //       ),
                                  //     ),
                                  //   ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 2.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                             categories![index]["category_name"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                           Text(
                                         categories![index]["category_description"].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),  SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                         categories![index]["last_topic_create_date"].toString()==""? "Last Post by: ${categories![index]["last_member_name"]}":  "Last Post by: ${categories![index]["last_member_name"]} | ${categories![index]["last_topic_create_date"].toString().substring(0,10)}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.topic_outlined,
                                        size: 16.sp,
                                        color: Theme.of(context).primaryColor,
                                      ), SizedBox(
                                    width: 5.w,
                                  ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 3),
                                        child: Text(
                                         categories![index]["topic_count"].toString(),
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
                        );
                      },
                    )
                
                ));
  }
}
