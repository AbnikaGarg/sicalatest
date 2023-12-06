import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_work.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';

class AddProvider extends StatefulWidget {
  AddProvider({super.key});

  @override
  State<AddProvider> createState() => _AddProviderState();
}

class _AddProviderState extends State<AddProvider> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobile = TextEditingController();

  final name = TextEditingController();

  final memberno = TextEditingController();

  final designation = TextEditingController();

  final skills = TextEditingController();

  final experience = TextEditingController();

  final medium = TextEditingController();

  final projectRequirement = TextEditingController();

  final notes = TextEditingController();
  final protfolioLink = TextEditingController();
  void submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);

      service
          .submitJobProvider(
              mobile.text,
              name.text,
              memberno.text,
              designation.text,
              skills.text,
              medium.text,
              experience.text,
              projectRequirement.text,
              notes.text, protfolioLink.text)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Job Provider Added",
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
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: const Text("Job Provider"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Requirement Details",
                    style: Theme.of(context).textTheme.displayMedium!),
                SizedBox(
                  height: 6.h,
                ),
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
                SizedBox(height: 8.h),
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
                MyTextField(
                    textEditingController: skills,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Skills";
                      }
                      return null;
                    },
                    hintText: "Skills",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),
                MyTextField(
                    textEditingController: medium,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Medium";
                      }
                      return null;
                    },
                    hintText: "Medium",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),
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
                MyTextField(
                    textEditingController: projectRequirement,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Project Requirement";
                      }
                      return null;
                    },
                    hintText: "Project Requirement",
                    color: const Color(0xff585A60)),
                 SizedBox(height: 8.h),
                MyTextField(
                    textEditingController: protfolioLink,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Protfolio Link";
                      }
                      return null;
                    },
                    hintText: "Protfolio Link",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),
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
      ),
    );
  }
}
