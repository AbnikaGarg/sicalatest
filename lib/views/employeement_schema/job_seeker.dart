import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';

class JobSeeker extends StatefulWidget {
  const JobSeeker({super.key});

  @override
  State<JobSeeker> createState() => _nameState();
}

class _nameState extends State<JobSeeker> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobile = TextEditingController();
  final name = TextEditingController();
  final memberno = TextEditingController();
  final designation = TextEditingController();
  final skills = TextEditingController();
  final skills2 = TextEditingController();
  final experience = TextEditingController();
  final portfiliolink = TextEditingController();
  final availablesDates = TextEditingController();
  final postApply = TextEditingController();
  final notes = TextEditingController();
  String pdfFile = "";
  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      // file = result.files.first;
      setState(() {
        pdfFile = file.path.toString();
      });
      print(file.name);
    } else {
      return;
    }
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      String img64 = "";
      if (pdfFile != "") {
        final bytes = io.File(pdfFile).readAsBytesSync();

        img64 = base64Encode(bytes);
      }
      final service = MemberRepo();
      DialogHelp.showLoading(context);

      service
          .submitJobSeeker(
              mobile.text,
              name.text,
              memberno.text,
              designation.text,
              skills.text,
              skills2.text,
              postApply.text,
              availablesDates.text,
              experience.text,
              portfiliolink.text,
              notes.text,
              pdfFile)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Job Seeker Added",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          title: const Text("Job Seeker"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mobile Number",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: mobile,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Mobile Number";
                        }
                        return null;
                      },
                      hintText: "Mobile number",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Member Name",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: name,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                      hintText: "Member Name",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Member Number",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: memberno,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Member Number";
                        }
                        return null;
                      },
                      hintText: "Member Number",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Designation/Grade",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
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
                  SizedBox(height: 8.h),
                  Text(
                    "Skills 1",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: skills,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Skills 1";
                        }
                        return null;
                      },
                      hintText: "Skill 1",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Skills 2",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: skills2,
                      hintText: "Skill 2",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Post Applying",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: postApply,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Post Applying";
                        }
                        return null;
                      },
                      hintText: "Post Applying",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Availables Dates",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      readOnly: true,
                      textEditingController: availablesDates,
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
                          availablesDates.text =
                              formattedDate; //set output date to TextField value.
                          setState(() {});
                        } else {
                          print("end from date is not selected");
                        }
                      },
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Availables Dates";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff585A60),
                        size: 18.sp,
                      ),
                      hintText: "Availables Dates",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Experience",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: experience,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Experience";
                        }
                        return null;
                      },
                      hintText: "Experience",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Portfolio Link",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: portfiliolink,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Portfolio Link";
                        }
                        return null;
                      },
                      hintText: "Portfolio Link",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Notes",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Notes";
                        }
                        return null;
                      },
                      hintText: "Notes",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 10.h),
                  Text(
                    "Document",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      uploadFile();
                    },
                    child: AspectRatio(
                      aspectRatio: 16 / 4,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppTheme.hintTextColor,
                              style: BorderStyle.solid,
                            ),
                            color: Color.fromARGB(255, 27, 26, 26),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "Upload Attachments",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: AppTheme.hintTextColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: RoundedButton(
                        ontap: () {
                          submit();
                        },
                        title: "Apply",
                        color: Theme.of(context).primaryColor,
                        textcolor: AppTheme.darkTextColor),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
