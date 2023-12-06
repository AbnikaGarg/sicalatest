import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';

class AssociateModel {
  String name;
  String mobile;
  int id;

  AssociateModel({
    this.name = "",
    this.mobile = "",
    required this.id,
  });
}

class AddAssociate extends StatefulWidget {
  AddAssociate({super.key});

  @override
  State<AddAssociate> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddAssociate> {
  List<WorkForm> workForm = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    AssociateModel _workModel = AssociateModel(id: 1);
    workForm.add(WorkForm(
      index: workForm.length,
      associateModel: _workModel,
      onRemove: () => onRemove(_workModel),
    ));
  }

  onRemove(AssociateModel work) {
    setState(() {
      int index =
          workForm.indexWhere((element) => element.associateModel.id == work.id);

      if (workForm != null) workForm.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      AssociateModel _associateModel = AssociateModel(id: workForm.length);
      workForm.add(WorkForm(
        index: workForm.length,
        associateModel: _associateModel,
        onRemove: () => onRemove(_associateModel),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title:const Text("Add Associate or Assistant"),
        actions: [
          IconButton(
              onPressed: () {
                onAdd();
              },
              icon:const Icon(
                Icons.add,
                //  color: AppTheme.bodyTextColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              if (workForm.isNotEmpty)
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: workForm.length,
                    itemBuilder: (_, index) {
                      return workForm[index];
                    })
              else
               const Center(child: Text("Tap on + to Add Associate or Assistant")),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26.h),
                child: RoundedButton(
                    ontap: () {},
                    title: "Save",
                    color: Theme.of(context).primaryColor,
                    textcolor: AppTheme.darkTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkForm extends StatefulWidget {
  WorkForm({
    super.key,
    this.index,
    required this.onRemove,
    required this.associateModel,
  });
  final index;
  AssociateModel associateModel;
  final Function onRemove;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  @override
  State<WorkForm> createState() => _WorkFormState();
}

class _WorkFormState extends State<WorkForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Member ${widget.index + 1}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: AppTheme.whiteBackgroundColor)),
              InkWell(
                onTap: () {
                  widget.onRemove();
                },
                child: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 247, 74, 62),
                ),
              )
            ],
          ),
          SizedBox(height: 8.h),
          MyTextField(
              // textEditingController: _controller.emailController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Name";
                }
                return null;
              },
              hintText: "Name",
              float: FloatingLabelBehavior.always,
              labelText: "",
              color: const Color(0xff585A60)),
          SizedBox(height: 8.h),
          MyTextField(
              textEditingController: widget._mobileController,
              float: FloatingLabelBehavior.always,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return "Mobile is required";
                }
                return null;
              },
              hintText: "Enter Mobile",
              labelText: "",
              color: const Color(0xff585A60)),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
