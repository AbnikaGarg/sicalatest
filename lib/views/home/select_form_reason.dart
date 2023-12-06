import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import 'form.dart';

class SelectReason extends StatefulWidget {
  const SelectReason({super.key});

  @override
  State<SelectReason> createState() => _nameState();
}

class _nameState extends State<SelectReason> {
  final reasonText = TextEditingController();
  List reasons = [
    "Payment issues",
    "Equipment issues",
    "Resources",
    "Enquiry",
    "Production issues"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        titleTextStyle: TextStyle(fontSize: 16.sp),
        title: const Text("Grievances"),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
       
          children: [
             Padding(
                  padding: EdgeInsets.only(bottom: 8.h, top: 30.h),
                  child: Text(
                    "Select Reason",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
            MyTextField(
                readOnly: true,
                textEditingController: reasonText,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Grievances is required";
                  }
                  return null;
                },
                ontap: () {
                  ModalSheet.showModal(context, reasons, (value) {
                    //  print(value);
                    //sss _controller.setMode(value);
                    setState(() {
                      reasonText.text = value;
                    });
                  }, reasonText.text);
                },
                hintText: "Your answer",
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff585A60),
                ),
                color: const Color(0xff585A60)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 26.h),
              child: RoundedButton(
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateDelayReport(),
                      ),
                    );
                  },
                  title: "Submit",
                  color: Theme.of(context).primaryColor,
                  textcolor: AppTheme.darkTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
