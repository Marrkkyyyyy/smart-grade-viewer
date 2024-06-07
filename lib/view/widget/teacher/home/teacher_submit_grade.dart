import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_class_page_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';

class TeacherSubmitGrade extends StatelessWidget {
  const TeacherSubmitGrade(
      {super.key,
      required this.controller,
      required this.isEdit,
      required this.classroomID});
  final TeacherClassPageController controller;
  final bool isEdit;
  final String classroomID;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherClassPageController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Dialog(
          child: Form(
            key: controller.formstate,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: 12),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEdit ? "Update Grade" : "Submit Grade",
                      style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: "Manrope",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Grade is required';
                        } else if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
                          return 'Enter a valid grade';
                        } else if (double.parse(value) < 1) {
                          return 'Enter a valid grade';
                        } else if (value.length == 1) {
                          controller.gradeController.text =
                              double.parse(value).toString();
                        }
                        return null;
                      },
                      controller: controller.gradeController,
                      maxLength: 3,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          isDense: true,
                          labelText: "Grade",
                          hintText: "0.0",
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            controller.clearData();
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
                          onTap: isEdit
                              ? () {
                                  if (controller.gradeController.text ==
                                      controller.grade.value) {
                                    Navigator.of(context).pop();
                                  } else {
                                    Get.back(result: true);
                                  }
                                }
                              : () {
                                  controller.validateInput(classroomID);
                                },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColor.lightIndigo,
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 30),
                            child: Center(
                              child: Text(
                                isEdit ? "Update" : "Submit",
                                style: const TextStyle(
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
    });
  }
}
