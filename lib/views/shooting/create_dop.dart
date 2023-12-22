import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sica/components/dynamic_modal_sheet.dart';
import 'package:sica/models/ShootingModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_work.dart';
import 'package:sica/views/shooting/add_associate.dart';
import 'package:sica/views/shooting/dop_list.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';
import 'package:intl/intl.dart';

class CreateDOP extends StatefulWidget {
  const CreateDOP({super.key, required this.associateList});
  final List associateList;
  @override
  State<CreateDOP> createState() => _CreateDOPState();
}

class _CreateDOPState extends State<CreateDOP> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List? associate;
  final mobile = TextEditingController();

  final name = TextEditingController();

  final memberno = TextEditingController();

  final designation = TextEditingController();

  final medium = TextEditingController();

  final projecttitle = TextEditingController();

  final startDate = TextEditingController();

  final endDate = TextEditingController();

  final notes = TextEditingController();
  final shooting = TextEditingController();
  @override
  void initState() {
    super.initState();
    getMedium();
    getMemberAllData();
    getDopList();
  }

  Future<bool> onWillPop() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MyDashBoard(currentIndex: 0)),
        (_) => false);
    return false;
  }

  List<ShootingAllDetails>? dopList;
  void getDopList() {
    final service = MemberRepo();
    service.getShootings().then((value) {
      if (value.isNotEmpty) {
        dopList = value.first.shootingAllDetails;
        // print(dopList!.first.shootingDetails!.designation);
        if (mounted) setState(() {});
      }
    });
  }

  submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .submitDop(
              int.parse(selValue!),
              mobile.text,
              name.text,
              memberno.text,
              designation.text,
              projecttitle.text,
              mediumid!,
              startDate.text,
              endDate.text,
              notes.text,
              associate!)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Dop Added",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyDashBoard(currentIndex: 0)),
              (_) => false);
          return false;
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

  String? mediumid;
  List mediumList = [];
  void getMedium() {
    final service = MemberRepo();
    service.getMediumService().then((value) {
      if (value.isNotEmpty) {
        mediumList = value;
        if (mounted) setState(() {});
      }
    });
  }

  List<MemberBasicDetails>? memberBasicDetails;
  List<MemberBasicDetails>? memberBasicDetails2;
  void getMemberAllData() {
    final service = MemberRepo();
    service.getAllMemberData().then((value) {
      if (value.isNotEmpty) {
        memberBasicDetails = value.first.memberBasicDetails!;
        memberBasicDetails2 = memberBasicDetails;
        print("loaded");

        if (mounted) setState(() {});
      }
    });
  }

  Timer? searchOnStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(
        () => searchOnStoppedTyping = new Timer(duration, () => search(value)));
  }

  search(value) {
    print(value);
    if (value.isNotEmpty) {
      memberBasicDetails2 = memberBasicDetails!
          .where((elem) =>
              elem.memberDetails!.membershipNo!.toString() == value.toString())
          .toList();
      if (memberBasicDetails2!.isNotEmpty) {
        mobile.text = memberBasicDetails2!.first.memberDetails!.mobileNumber!;
        name.text = memberBasicDetails2!.first.memberDetails!.name!;
        designation.text =
            memberBasicDetails2!.first.memberDetails!.designation!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        //   backgroundColor: AppTheme.whiteBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          centerTitle: false,
          title: const Text("Create DOP"),
          actions: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddWork()))
                      .then((value) {
                    associate = value;
                    setState(() {});
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "+ Add Associate",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 15.sp, color: AppTheme.blackColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("Shooting Details",
                  //     style: Theme.of(context).textTheme.headlineMedium!),
                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  MyTextField(
                      textEditingController: memberno,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Membership Number";
                        }
                        return null;
                      },
                      onChanged: _onChangeHandler,
                      hintText: "Membership Number",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  MyTextField(
                      textEditingController: mobile,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Mobile Number";
                        }
                        return null;
                      },
                      fillcolor: Theme.of(context).cardColor,
                      hintText: "Mobile number",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  MyTextField(
                      textEditingController: name,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                      hintText: "Name",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),

                  MyTextField(
                      textEditingController: designation,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Designation/Grade";
                        }
                        return null;
                      },
                      hintText: "Designation/Grade",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  MyTextField(
                      textEditingController: projecttitle,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Project Title";
                        }
                        return null;
                      },
                      hintText: "Project Title",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  if (mediumList.isNotEmpty)
                    MyTextField(
                        textEditingController: medium,
                        readOnly: true,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Select Medium";
                          }
                          return null;
                        },
                        ontap: () {
                          ModalSheet.showModal(
                              context, mediumList[0], "medium_name", (value) {
                            setState(() {
                              medium.text = value;
                            });
                          }, (value) {
                            mediumid =
                                mediumList[0][value]["medium_id"].toString();
                            setState(() {});
                          }, medium.text);
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xff585A60),
                        ),
                        hintText: "Select Medium",
                        color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),

                  if (dopList != null)
                    if (dopList!.isNotEmpty)
                      MyTextField(
                          textEditingController: shooting,
                          readOnly: true,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Select Shooting";
                            }
                            return null;
                          },
                          ontap: () {
                            showModal();
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff585A60),
                          ),
                          hintText: "Select Shooting",
                          color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  MyTextField(
                      readOnly: true,
                      textEditingController: startDate,
                      ontap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          print(formattedDate);
                          startDate.text =
                              formattedDate; //set output date to TextField value.
                          setState(() {});
                        } else {
                          print("Start from date is not selected");
                        }
                      },
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Start Date";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff585A60),
                      ),
                      hintText: "Start Date",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  MyTextField(
                      readOnly: true,
                      textEditingController: endDate,
                      ontap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          print(formattedDate);
                          endDate.text =
                              formattedDate; //set output date to TextField value.
                        } else {
                          print("end from date is not selected");
                        }
                      },
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter End Date";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff585A60),
                      ),
                      hintText: "End Date",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),

                  MyTextField(
                      textEditingController: notes,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Outdoor link details";
                        }
                        return null;
                      },
                      hintText: "Outdoor link",
                      color: const Color(0xff585A60)),
                      if(associate!=null)
                  if (associate!.length != 0)
                    ListView.builder(
                      itemCount: associate!.length,
                      primary: false,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${associate![index]["name"]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 15.sp),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "${associate![index]["mobile_number"]}",
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
                                  // GestureDetector(
                                  //   //  behavior: HitTestBehavior.opaque,
                                  //   onTap: () {
                                  //     Navigator.of(context).push(MaterialPageRoute(
                                  //         builder: (context) => AddAssociate(
                                  //               associate: widget.shootingdetials
                                  //                   .associate![index],
                                  //               shootingid: widget.shootingdetials
                                  //                   .shootingDopDetails!.shootingId
                                  //                   .toString(),
                                  //             )));
                                  //   },
                                  //   child: Icon(Icons.edit,
                                  //       size: 17.sp, color: Colors.white),
                                  // ),
                                  // SizedBox(
                                  //   height: 5.h,
                                  // ),
                                  Text(
                                    "M No. ${associate![index]['member_number']}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 13.sp,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 12),
                    child: RoundedButton(
                        ontap: () {
                          submit();
                        },
                        title: "Apply",
                        height: 40,
                        color: Theme.of(context).primaryColor,
                        textcolor: AppTheme.darkTextColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? selValue;
  void showModal() {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0.r),
            topRight: Radius.circular(10.0.r),
          ),
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        // useSafeArea: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //  Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // Icon(
                    //   Icons.remove,
                    //   color: Colors.grey[600],
                    //   size: 40,
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dopList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      dopList![index]
                                          .shootingDetails!
                                          .projectTitle!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 15.sp),
                                    ),
                                    if (dopList![index]
                                            .shootingDetails!
                                            .shootingId!
                                            .toString() ==
                                        selValue)
                                      Icon(CupertinoIcons.checkmark,
                                          size: 24.sp, color: Colors.blue)
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       border: Border.all(
                                    //         color: Theme.of(context)
                                    //             .canvasColor,
                                    //       )),
                                    //       alignment: Alignment.center,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(2),
                                    //     child: Icon(Icons.circle,
                                    //         size: 10.sp,
                                    //         color: Colors.blue),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              onTap: () {
                                // Get.find<AccountSetUpController>()
                                //     .setAccountValue(items[index]);
                                //    _controller.accountType.value =  TextEditingController(text: _items[index]);

                                selValue = dopList![index]
                                    .shootingDetails!
                                    .shootingId!
                                    .toString();
                                shooting.text = dopList![index]
                                    .shootingDetails!
                                    .projectTitle!
                                    .toString();
                                setState(() {});
                                Navigator.pop(context);
                              });
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                  ]),
                ),
              ));
        });
  }
}
