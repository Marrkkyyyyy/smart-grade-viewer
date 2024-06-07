import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_class_page_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/data/model/teacher_student_model.dart';
import 'package:smart_grade_viewer/view/widget/custom_confirmation_dialog.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/teacher_submit_grade.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/teacher_view_feedback.dart';

class CustomStudentList extends StatelessWidget {
  const CustomStudentList(
      {super.key, required this.controller, required this.student});
  final TeacherClassPageController controller;
  final TeacherStudentModel student;
  @override
  Widget build(BuildContext context) {
    String fullName = "${student.lastName}, ${student.firstName}";
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      child: GestureDetector(
        onTap: student.grade == "null"
            ? () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TeacherSubmitGrade(
                        controller: controller,
                        classroomID: student.classroomID!,
                        isEdit: false,
                      );
                    });
              }
            : () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return TeacherViewFeedback(
                        grade: student.grade!,
                        fullName: "${student.lastName}, ${student.firstName}",
                        classroomID: student.classroomID!,
                        controller: controller,
                        student: student,
                      );
                    });
              },
        child: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          child: Slidable(
            endActionPane: ActionPane(
              dragDismissible: false,
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomConfirmationDialog(
                              titleText: "Unenroll Student",
                              message:
                                  "Are you sure you want to unenroll this student? This action will permanently delete all data related to the student. Please confirm if you wish to proceed.",
                              onCancel: () {
                                Navigator.of(context).pop();
                              },
                              onConfirm: controller.statusRequestUnenroll ==
                                      StatusRequest.loading
                                  ? () {
                                      Navigator.of(context).pop();
                                    }
                                  : () {
                                      Navigator.of(context).pop();
                                      controller.unenrollStudent(
                                          student.classroomID!,
                                          student.studentID!,
                                          student.teacherClassID!);
                                    });
                        });
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Unenroll",
                )
              ],
            ),
            child: Container(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  border: const Border(
                    left: BorderSide(color: AppColor.darkIndigo, width: 5.5),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.2,
                        blurRadius: 3,
                        offset: const Offset(1, 2)),
                  ],
                ),
                child: Container(
                    margin: const EdgeInsets.only(left: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                foregroundColor: Colors.white,
                                radius: 25,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fullName,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: "Manrope", fontSize: 16),
                                    ),
                                    student.feedback[0].feedbackID == "null"
                                        ? const SizedBox()
                                        : const Icon(
                                            Icons.message,
                                            size: 14,
                                            color: Colors.blue,
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            student.grade == "null" ? "N/A" : student.grade!,
                            style: student.grade == "null"
                                ? const TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38)
                                : TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: double.parse(student.grade!) >= 2 &&
                                            double.parse(student.grade!) <= 3
                                        ? Colors.orange
                                        : double.parse(student.grade!) > 3
                                            ? Colors.red
                                            : Colors.teal),
                          ),
                        )
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
