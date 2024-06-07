import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_color_picker.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_field_create_class.dart';

class CreateNewClass extends StatelessWidget {
  const CreateNewClass({super.key, required this.controller});
  final TeacherDashboardController controller;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherDashboardController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets,
          child: Form(
            key: controller.formstate,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 15),
                        width: 60,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 224, 224, 224),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Create New Class",
                        style: TextStyle(
                            color: AppColor.lightIndigo,
                            fontFamily: "Manrope",
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomFieldCreateClass(
                      valid: (val) {
                        if (val!.isEmpty) {
                          return "Enter required field";
                        } else {
                          return null;
                        }
                      },
                      controller: controller.className,
                      autoFocus: true,
                      labelText: "Class Name",
                      textCapitalization: TextCapitalization.words,
                      maxLength: 50,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomFieldCreateClass(
                      valid: (val) {
                        if (val!.isEmpty) {
                          return "Enter required field";
                        } else {
                          return null;
                        }
                      },
                      controller: controller.classCode,
                      labelText: "Class Code",
                      maxLength: 8,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomFieldCreateClass(
                      valid: (val) {
                        if (val!.isEmpty) {
                          return "Enter required field";
                        } else if (val == "0" || val == "00") {
                          return "Invalid Block";
                        } else {
                          return null;
                        }
                      },
                      controller: controller.block,
                      textInputFormatter:
                          FilteringTextInputFormatter.digitsOnly,
                      textInputType: TextInputType.number,
                      labelText: "Block",
                      hintText: "0",
                      maxLength: 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              controller.semester = "1";
                              controller.update();
                            },
                            child: controller.semester == "1"
                                ? Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5,
                                            color: AppColor.lightIndigo),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(6)),
                                    height: 40,
                                    child: const Center(
                                        child: Text(
                                      "Semester 1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.lightIndigo,
                                          fontSize: 14,
                                          fontFamily: "Manrope"),
                                    )),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: .5, color: Colors.black38),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(6)),
                                    height: 40,
                                    child: const Center(
                                        child: Text(
                                      "Semester 1",
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Manrope"),
                                    )),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              controller.semester = "2";
                              controller.update();
                            },
                            child: controller.semester == "2"
                                ? Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5,
                                            color: AppColor.lightIndigo),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(6)),
                                    height: 40,
                                    child: const Center(
                                        child: Text(
                                      "Semester 2",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.lightIndigo,
                                          fontSize: 14,
                                          fontFamily: "Manrope"),
                                    )),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: .5, color: Colors.black38),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(6)),
                                    height: 40,
                                    child: const Center(
                                        child: Text(
                                      "Semester 2",
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Manrope"),
                                    )),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomColorPicker(
                                      controller: controller);
                                });
                          }, child: Obx(() {
                            return Container(
                              decoration: BoxDecoration(
                                  color: controller.containerColor.value,
                                  borderRadius: BorderRadius.circular(6)),
                              height: 40,
                              width: MediaQuery.of(context).size.width * .5,
                              child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  )),
                            );
                          })),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: controller.statusRequestNew ==
                              StatusRequest.loading
                          ? () {}
                          : () {
                              controller.validateInput();
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(83, 92, 145, 1),
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
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
                    ),
                  ]),
            ),
          ),
        ),
      );
    });
  }
}
