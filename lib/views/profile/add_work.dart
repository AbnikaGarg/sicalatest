// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../components/buton.dart';
// import '../../components/input_feild.dart';
// import '../../theme/theme.dart';

// class WorkModel {
//   String name;
//   String year;
//   int id;
//   String designation;

//   WorkModel({
//     this.name = "",
//     this.year = "",
//     this.designation = "",
//     required this.id,
//   });
// }

// class AddWork extends StatefulWidget {
//   AddWork({super.key});

//   @override
//   State<AddWork> createState() => _AddWorkState();
// }

// class _AddWorkState extends State<AddWork> {
//   List<WorkForm> workForm = List.empty(growable: true);
//   @override
//   void initState() {
//     super.initState();
//     WorkModel _workModel = WorkModel(id: 1);
//     workForm.add(WorkForm(
//       index: workForm.length,
//       workModel: _workModel,
//       onRemove: () => onRemove(_workModel),
//     ));
//   }

//   onRemove(WorkModel work) {
//     setState(() {
//       int index =
//           workForm.indexWhere((element) => element.workModel.id == work.id);

//       if (workForm != null) workForm.removeAt(index);
//     });
//   }

//   onAdd() {
//     setState(() {
//       WorkModel _workModel = WorkModel(id: workForm.length);
//       workForm.add(WorkForm(
//         index: workForm.length,
//         workModel: _workModel,
//         onRemove: () => onRemove(_workModel),
//       ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0,
//         elevation: 1,
//         title: Text("Add Project"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 onAdd();
//               },
//               icon: Icon(
//                 Icons.add,
//               //  color: AppTheme.bodyTextColor,
//               ))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//           child: Column(
//             children: [
//               SizedBox(height: 5.h),
//               if (workForm.isNotEmpty)
//                 ListView.builder(
//                     primary: false,
//                     shrinkWrap: true,
//                     itemCount: workForm.length,
//                     itemBuilder: (_, index) {
//                       return workForm[index];
//                     })
//               else
//                 Center(child: Text("Tap on + to Add work")),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.h),
//                 child: RoundedButton(
//                     ontap: () {},
//                     title: "Save",
//                     color: Theme.of(context).primaryColor,
//                     textcolor: AppTheme.darkTextColor),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WorkForm extends StatefulWidget {
//   WorkForm({
//     super.key,
//     this.index,
//     required this.onRemove,
//     required this.workModel,
//   });
//   final index;
//   WorkModel workModel;
//   final Function onRemove;

//   TextEditingController _nameController = TextEditingController();

//   TextEditingController _yearController = TextEditingController();

//   TextEditingController _designationController = TextEditingController();
//   @override
//   State<WorkForm> createState() => _WorkFormState();
// }

// class _WorkFormState extends State<WorkForm> {
//   String showYear = 'Select Year';
//   DateTime _selectedYear = DateTime.now();

//   selectYear(context) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: AppTheme.cardDarkColor,
//           title:  Text("Select Year", style: TextStyle(color: AppTheme.whiteBackgroundColor),),
//           content: Container(
//             width: 300.w,
//             height: 300.h,
//             child: YearPicker(
              
//               firstDate: DateTime(DateTime.now().year - 50, 1),
//               // lastDate: DateTime.now(),
//               lastDate: DateTime(DateTime.now().year + 10, 1),
//               initialDate: DateTime.now(),
//               selectedDate: _selectedYear,
//               onChanged: (DateTime dateTime) {
//                 print(dateTime.year);
//                 setState(() {
//                   _selectedYear = dateTime;
//                   widget._yearController.text = dateTime.year.toString();
//                   showYear = "${dateTime.year}";
//                   print(showYear);
//                   setState(() {});
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Project ${widget.index + 1}",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineMedium!
//                       .copyWith(color: AppTheme.whiteBackgroundColor)),
//               InkWell(
//                 onTap: () {
//                   widget.onRemove();
//                 },
//                 child: const Icon(
//                   Icons.delete,
//                   color: Color.fromARGB(255, 247, 74, 62),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(height: 8.h),
//           MyTextField(
//               // textEditingController: _controller.emailController,
//               validation: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Enter Name";
//                 }
//                 return null;
//               },
//               hintText: "Name",
//               float: FloatingLabelBehavior.always,
//               labelText: "",
//               color: const Color(0xff585A60)),
//           SizedBox(height: 8.h),
//           MyTextField(
//               textEditingController: widget._yearController,
//               validation: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Year is required";
//                 }
//                 return null;
//               },
//               ontap: () {
//                 selectYear(context);
//               },
//               icon: Icon(Icons.calendar_month),
//               readOnly: true,
//               hintText: "Select Year",
//               float: FloatingLabelBehavior.always,
//               labelText: "",
//               color: const Color(0xff585A60)),
//           SizedBox(height: 8.h),
//           MyTextField(
//               textEditingController: widget._designationController,
//               ontap: () {
//                 showDesModel(context);
//               },
//               icon: Icon(Icons.arrow_drop_down),
//               readOnly: true,
//               float: FloatingLabelBehavior.always,
//               validation: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Designation is required";
//                 }
//                 return null;
//               },
//               hintText: "Select Designation",
//               labelText: "",
//               color: const Color(0xff585A60)),
         
//         ],
//       ),
//     );
//   }

//   List designation = [
//     "Assistant Cinematography",
//     "Assistant Cinematography2",
//     "Assistant Cinematography 3"
//   ];
//   void showDesModel(context) {
//     showModalBottomSheet(
//         context: context,
//         enableDrag: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10.0.r),
//             topRight: Radius.circular(10.0.r),
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         // useSafeArea: true,
//         builder: (context) {
//           return GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: (() {
//                 Navigator.of(context).pop();
//               }),
//               child: SingleChildScrollView(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).scaffoldBackgroundColor,
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(12.0),
//                       topRight: Radius.circular(12.0),
//                     ),
//                   ),
//                   alignment: Alignment.center,
//                   child: Column(mainAxisSize: MainAxisSize.min, children: [
//                     // Icon(
//                     //   Icons.remove,
//                     //   color: Colors.grey[600],
//                     //   size: 40,
//                     // ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     Container(
//                       width: 40.w,
//                       height: 4.h,
//                       decoration: BoxDecoration(
//                           color: Colors.grey[600],
//                           borderRadius: BorderRadius.circular(12)),
//                     ),
//                     SizedBox(
//                       height: 15.h,
//                     ),
//                     ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: designation.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 12.w, vertical: 12.h),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       designation[index],
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodySmall!
//                                           .copyWith(fontSize: 15.sp),
//                                     ),
//                                     if (designation[index] ==
//                                         widget._designationController.text
//                                             .toString())
//                                       Icon(CupertinoIcons.checkmark,
//                                           size: 24.sp, color: Colors.blue)
//                                   ],
//                                 ),
//                               ),
//                               onTap: () {
//                                 setState(() {
//                                   widget._designationController.text =
//                                       designation[index];
//                                 });
//                                 Navigator.pop(context);
//                               });
//                         }),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                   ]),
//                 ),
//               ));
//         });
//   }
// }
