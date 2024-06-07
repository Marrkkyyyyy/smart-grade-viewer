import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_class_page_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/data/model/teacher_student_model.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/teacher_submit_grade.dart';

class TeacherViewFeedback extends StatelessWidget {
  const TeacherViewFeedback(
      {super.key,
      required this.controller,
      required this.classroomID,
      required this.fullName,
      required this.grade,
      required this.student});
  final TeacherClassPageController controller;
  final String classroomID;
  final String fullName;
  final String grade;
  final TeacherStudentModel student;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
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
              Text(
                fullName,
                style: const TextStyle(
                    fontFamily: "Manrope",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColor.darkIndigo),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 6, right: 6, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color:
                          double.parse(grade) >= 2 && double.parse(grade) <= 3
                              ? Colors.orange
                              : double.parse(grade) > 3
                                  ? Colors.red
                                  : Colors.teal,
                    ),
                    child: Column(
                      children: [
                        Text(grade,
                            style: const TextStyle(
                                fontFamily: "Manrope",
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800)),
                        const Text(
                          "Final Grade",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            controller.gradeController.text =
                                controller.grade.value = grade;
                            return TeacherSubmitGrade(
                              classroomID: classroomID,
                              controller: controller,
                              isEdit: true,
                            );
                          }).then((value) {
                        if (value == true) {
                          controller.validateInput(classroomID);
                        }
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromARGB(20, 0, 0, 0)),
                        child: const Icon(
                          Icons.edit,
                          color: AppColor.darkIndigo,
                          size: 18,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              const Divider(
                thickness: 1,
                height: 0,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                "Feedback",
                style: TextStyle(
                    fontFamily: "Manrope",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              const SizedBox(
                height: 6,
              ),
              controller.statusRequest != StatusRequest.success
                  ? const SizedBox()
                  : student.feedback[0].feedbackID == "null"
                      ? Container(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: const Center(
                            child: Text(
                              "No feedback yet ",
                              style: TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ...List.generate(student.feedback.length, (index) {
                              FeedbackItem feedback = student.feedback[index];
                              bool teacherReplied =
                                  feedback.senderID == controller.teacherID;

                              return Column(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Align(
                                      alignment: teacherReplied
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: teacherReplied
                                              ? AppColor.skyBlue
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .8,
                                        ),
                                        child: Text(
                                          feedback.message!,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontFamily: "Manrope",
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (teacherReplied)
                                    Column(
                                      children: const [
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Text(
                                          "You've already responded",
                                          style: TextStyle(
                                            fontFamily: "Manrope",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              );
                            }),
                            if (!student.feedback.any((feedback) =>
                                feedback.senderID == controller.teacherID))
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (controller.isFocused.value)
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 6, bottom: 4),
                                            child: Obx(() {
                                              return Text(
                                                "${controller.feedbackCharacterCount.value} / 150",
                                                style: const TextStyle(
                                                  fontFamily: "Manrope",
                                                  fontSize: 12,
                                                ),
                                              );
                                            }),
                                          ),
                                        TextFormField(
                                          style: const TextStyle(
                                            fontFamily: "Manrope",
                                          ),
                                          onChanged: (value) {
                                            controller.updateCharacterCount();
                                          },
                                          controller:
                                              controller.feedbackController,
                                          focusNode: controller.focusNode,
                                          maxLength: 150,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                            hintStyle: TextStyle(
                                              fontFamily: "Manrope",
                                            ),
                                            labelStyle: TextStyle(
                                              fontFamily: "Manrope",
                                            ),
                                            counterText: "",
                                            isDense: true,
                                            hintText: "Type a message...",
                                            labelText: 'Reply',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: controller.statusRequestReply ==
                                            StatusRequest.loading
                                        ? () {}
                                        : () {
                                            controller.replyFeedback(
                                                student.studentID!);
                                          },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 4),
                                      color: Colors.transparent,
                                      height: 50,
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.blue,
                                        size: 28,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                          ],
                        )
            ],
          ),
        ),
      ),
    );
  }
}
