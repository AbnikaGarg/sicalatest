import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sica/components/dynamic_modal_sheet.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_work.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';
import 'package:intl/intl.dart';

class CreateShooting extends StatefulWidget {
  CreateShooting({super.key});

  @override
  State<CreateShooting> createState() => _CreateShootingState();
}

class _CreateShootingState extends State<CreateShooting> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobile = TextEditingController();

  final name = TextEditingController();

  final memberno = TextEditingController();

  final designation = TextEditingController();

  final medium = TextEditingController();

  final projecttitle = TextEditingController();

  final startDate = TextEditingController();

  final endDate = TextEditingController();

  final approvalTypeText = TextEditingController();
  final notes = TextEditingController();
  List approvalType = [
    {"ans": "Yes"},
    {"ans": "No"}
  ];
  @override
  void initState() {
    super.initState();
    getMedium();
    getMemberAllData();
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

  submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .submitShooting(
              mobile.text,
              name.text,
              memberno.text,
              designation.text,
              projecttitle.text,
              mediumid!,
              startDate.text,
              endDate.text,
              notes.text,
              approvalTypeText.text)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Shooting Added",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyDashBoard(currentIndex: 0)),
              (_) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: const Text("Create Shooting"),
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
                    onChanged: _onChangeHandler,
                    textEditingController: memberno,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Membership Number";
                      }
                      return null;
                    },
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
                MyTextField(
                    textEditingController: approvalTypeText,
                    readOnly: true,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Select DOP for approval";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, approvalType, "ans",
                          (value) {
                        //  print(value);
                        //sss _controller.setMode(value);
                        setState(() {
                          approvalTypeText.text = value;
                        });
                      }, (value) {}, approvalTypeText.text);
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    hintText: "Select DOP for approval",
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
                        return "Enter Notes";
                      }
                      return null;
                    },
                    hintText: "Notes",
                    color: const Color(0xff585A60)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12),
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
    );
  }
}
