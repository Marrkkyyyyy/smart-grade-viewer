import 'package:flutter/material.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/data/model/teacher_student_model.dart';

class CustomTeacherStudentRankings extends StatelessWidget {
  const CustomTeacherStudentRankings(
      {super.key,
      required this.size,
      required this.student,
      required this.index});
  final Size size;
  final TeacherStudentModel student;
  final int index;
  @override
  Widget build(BuildContext context) {
    String fullName = "${student.lastName}, ${student.firstName}";
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      child: Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          width: size.width * 1,
          decoration: BoxDecoration(
            border: const Border(
              left: BorderSide(color: AppColor.lightIndigo, width: 5.5),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.2,
                blurRadius: 3,
                offset: const Offset(1, 2),
              ),
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
                        const SizedBox(
                          width: 6,
                        ),
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
                              student.grade == "null"
                                  ? const Text(
                                      "N/A",
                                      style: TextStyle(
                                          fontFamily: "Manrope",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black38),
                                    )
                                  : Text(
                                      student.grade!,
                                      style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: student.grade == "null"
                                            ? AppColor.darkBlue
                                            : double.parse(student.grade!) >=
                                                        2 &&
                                                    double.parse(
                                                            student.grade!) <=
                                                        3
                                                ? Colors.orange
                                                : double.parse(student.grade!) >
                                                        3
                                                    ? Colors.red
                                                    : Colors.teal,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  index > 10
                      ? const SizedBox()
                      : Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45),
                              text: '',
                              children: [
                                TextSpan(
                                  text: index.toString(),
                                  style: const TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black45),
                                ),
                                TextSpan(
                                  text: index == 1
                                      ? "st"
                                      : index == 2
                                          ? "nd"
                                          : index == 3
                                              ? "rd"
                                              : (index >= 4 && index <= 10)
                                                  ? 'th'
                                                  : "",
                                  style: const TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black45),
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ))),
    );
  }
}
