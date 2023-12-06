import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/views/profile/add_work.dart';
import 'package:sica/views/shooting/add_associate.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';
import 'package:intl/intl.dart';

class CreateDOP extends StatelessWidget {
  const CreateDOP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: const Text("Creating DOP Project Upadate"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shooting Details",
                          style: Theme.of(context).textTheme.headlineMedium!),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddAssociate()));
                        },
                        child: Container(
                        //  margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          decoration: BoxDecoration(
                              color: Color(0xFF686868),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "+ Add Associate",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontSize: 14.sp,
                                    color: AppTheme.whiteBackgroundColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  MyTextField(
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Mobile Number";
                        }
                        return null;
                      },
                      fillcolor: Theme.of(context).cardColor,
                      hintText: "Mobile number",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 5.h),
                  MyTextField(
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                      hintText: "Name",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 5.h),
                  MyTextField(
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Member Number";
                        }
                        return null;
                      },
                      hintText: "Member Number",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 5.h),
                  MyTextField(
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Designation/Grade";
                        }
                        return null;
                      },
                      hintText: "Designation/Grade",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 5.h),
                  MyTextField(
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Project Title";
                        }
                        return null;
                      },
                      hintText: "Project Title",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 5.h),
                  MyTextField(
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Medium";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xff585A60),
                      ),
                      hintText: "Medium",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 5.h),
                  MyTextField(
                      readOnly: true,
                      ontap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('dd-MMM-yyyy').format(pickedDate);
                          print(formattedDate);
                          //  _controller.fromDate.text =
                          //    formattedDate; //set output date to TextField value.
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
                  SizedBox(height: 5.h),
                  MyTextField(
                      readOnly: true,
                      ontap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('dd-MMM-yyyy').format(pickedDate);
                          print(formattedDate);
                          //  _controller.fromDate.text =
                          //    formattedDate; //set output date to TextField value.
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
                  SizedBox(height: 5.h),
                  MyTextField(
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Outdoor Link Details";
                        }
                        return null;
                      },
                      hintText: "Outdoor Link Details",
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
                        title: "Apply",
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
}
