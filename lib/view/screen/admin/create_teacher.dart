import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/admin/admin_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/functions/valid_input.dart';
import 'package:smart_grade_viewer/view/widget/admin/custom_create_teacher_textfield.dart';

class CreateTeacher extends StatelessWidget {
  const CreateTeacher({super.key, required this.controller});
  final AdminDashboardController controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formstate,
          child: Container(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 12),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create New Teacher",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "Manrope",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomCreateTeacherTextfield(
                      autoFocus: true,
                      controller: controller.firstName,
                      valid: (val) {
                        return validInput(val, "name");
                      },
                      textCapitalization: TextCapitalization.words,
                      icon: Icons.person,
                      labelText: "First Name",
                      hintText: "Enter first name"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomCreateTeacherTextfield(
                      controller: controller.lastName,
                      valid: (val) {
                        return validInput(val, "name");
                      },
                      textCapitalization: TextCapitalization.words,
                      icon: Icons.person,
                      labelText: "Last Name",
                      hintText: "Enter last name"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomCreateTeacherTextfield(
                      controller: controller.emailAddress,
                      textInputType: TextInputType.emailAddress,
                      valid: (val) {
                        if (val!.isEmpty) {
                          return "Enter required field";
                        } else if (!val.isEmail) {
                          return "Enter valid email";
                        } else {
                          return null;
                        }
                      },
                      icon: Icons.email,
                      labelText: "Email Address",
                      hintText: "Enter email address"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 196, 196, 196),
                              borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: const Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 16,
                                  color: Colors.black45),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.validateInput(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.darkBlue,
                              borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 30),
                          child: const Center(
                            child: Text(
                              "Create",
                              style: TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
