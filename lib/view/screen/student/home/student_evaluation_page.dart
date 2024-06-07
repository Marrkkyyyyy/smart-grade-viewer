import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/student/student_evaluation_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/view/widget/dialog_message.dart';
import 'package:smart_grade_viewer/view/widget/teacher/confirmation_dialog.dart';

class StudentEvaluationPage extends StatelessWidget {
  final StudentEvaluationController controller =
      Get.put(StudentEvaluationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 35,
          title: const Text(
            "Evaluation",
            style: TextStyle(fontFamily: "Manrope"),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const DialogMessage(
                            color: AppColor.orange,
                            message:
                                "Please note that your responses will not affect your grades, and all data collected will be kept anonymous to ensure confidentiality.");
                      });
                },
                icon: const Icon(Icons.info_outline))
          ],
          backgroundColor: AppColor.orange,
        ),
        body: GetBuilder<StudentEvaluationController>(builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                        controller.evaluationQuestions.length, (index) {
                      int numQuestion = index + 1;
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(
                              top: 12, left: 16, right: 12, bottom: 8),
                          minLeadingWidth: 0,
                          leading: Text(
                            "$numQuestion.",
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                          title: Text(
                            controller.evaluationQuestions[index],
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Manrope",
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: List.generate(5, (indexRadio) {
                                  return radioButton(
                                      controller.likertScale[indexRadio],
                                      index);
                                }),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: controller.commentController,
                    maxLines: 3,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter required field";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(fontFamily: "Manrope"),
                    decoration: const InputDecoration(
                      counterText: "",
                      floatingLabelStyle: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.skyBlue,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Comment",
                      hintStyle: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                      labelStyle:
                          TextStyle(fontFamily: "Manrope", fontSize: 18),
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.skyBlue),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 1, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: AppColor.skyBlue,
                    ),
                    onPressed: () {
                      if (controller.radioValues.contains('')) {
                        showErrorMessage("Please answer all questions");
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmationDialog(
                                  colorConfirmText: AppColor.orange,
                                  message:
                                      "This action cannot be undone. Are you sure you want to proceed with submitting your evaluation?",
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                  onConfirm: () {
                                    Navigator.of(context).pop();
                                    controller.submitEvaluate();
                                  });
                            });
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget radioButton(String val, int index) {
    return Row(
      children: [
        Radio(
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          value: val,
          groupValue: controller.radioValues[index],
          onChanged: (value) {
            controller.radioValues[index] = val;
            controller.update();
          },
        ),
        Text(
          val,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontFamily: "Manrope",
          ),
        ),
      ],
    );
  }
}
