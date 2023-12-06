import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/views/profile/add_work.dart';
import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';
import 'package:intl/intl.dart';

class CreateDelayReport extends StatefulWidget {
  CreateDelayReport({super.key});

  @override
  State<CreateDelayReport> createState() => _CreateDelayReportState();
}

class _CreateDelayReportState extends State<CreateDelayReport> {
  String radioButtonItem = 'Yes';
  final cameraIssueText = TextEditingController();
  final outdorrIssueText = TextEditingController();
  final issueTypeText = TextEditingController();
  List issueType = ["Yes", "No"];
  List outdorrIssue = ["Yes", "No"];
  List CameraIssue = ["Camera", "Lens", "Lights", "Grips"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        titleTextStyle: TextStyle(fontSize: 16.sp),
        title: const Text("Shooting Equipment’s Delay Report "),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "MEMBER NAME & M.NO",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter MEMBER NAME & M.NO";
                      }
                      return null;
                    },
                    fillcolor: Theme.of(context).cardColor,
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Name",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "PROJECT NAME",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter PROJECT NAME";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "PRODUCTION HOUSE NAME",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter PRODUCTION HOUSE NAME";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "OUTDOOR UNIT NAME",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter OUTDOOR UNIT NAME";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "LOCATION",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter LOCATION";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Issues Arised  in Camera & Lens or Lights or Grips",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    readOnly: true,
                    textEditingController: cameraIssueText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Issues Arised  in Camera & Lens or Lights or Grips";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, CameraIssue, (value) {
                        //  print(value);
                        //sss _controller.setMode(value);
                        setState(() {
                          cameraIssueText.text = value;
                        });
                      },cameraIssueText.text );
                    },
                    hintText: "Your answer",
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Approximate Time Lost Due to the Problem",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Approximate Time Lost Due to the Problem";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Name and Contact No of Outdoor Unit Manager",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name and Contact No of Outdoor Unit Manager.";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Has Outdoor unit manager was helpful to solve the issue",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    textEditingController: issueTypeText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Has Outdoor unit manager was helpful to solve the issue.";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, issueType, (value) {
                       setState(() {
                          issueTypeText.text = value;
                        });
                      },issueTypeText.text);
                    },
                    readOnly: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Has the Issue been reported to the Production Manager / Executive Producer",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                   textEditingController: outdorrIssueText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Has the Issue been reported to the Production Manager / Executive Producer";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, outdorrIssue, (value) {
                         setState(() {
                          outdorrIssueText.text = value;
                        });
                      },outdorrIssueText.text);
                    },
                    readOnly: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Name and Contact No of the Production Manager / Executive Producer",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name and Contact No of the Production Manager / Executive Producer.";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Brief the issues you faced with the service of Outdoor  Unit / Equipments",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                MyTextField(

                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Brief the issues you faced with the service of Outdoor  Unit / Equipments";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 26.h),
                  child: RoundedButton(
                      ontap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OtpScreen(),
                        //   ),
                        // );
                      },
                      title: "Submit",
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
