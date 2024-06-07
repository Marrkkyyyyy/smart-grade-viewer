import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/data/model/student_class_model.dart';
import 'package:smart_grade_viewer/link_api.dart';

class StudentCustomStudentList extends StatelessWidget {
  const StudentCustomStudentList(
      {super.key,
      required this.size,
      required this.student,
      required this.studentID,
      required this.index});
  final Size size;
  final StudentClassModel student;
  final String studentID;
  final int index;
  @override
  Widget build(BuildContext context) {
    String fullName = "${student.studentLastName}, ${student.studentFirstName}";
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      child: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          width: size.width * 1,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.2,
                blurRadius: 3,
                offset: const Offset(1, 2),
              ),
            ],
            border: Border(
              left: BorderSide(
                  color: student.grade == "null"
                      ? AppColor.darkBlue
                      : double.parse(student.grade!) >= 2 &&
                              double.parse(student.grade!) <= 3
                          ? Colors.orange
                          : double.parse(student.grade!) > 3
                              ? Colors.red
                              : Colors.teal,
                  width: 5.5),
            ),
          ),
          child: Container(
              margin: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        student.studentProfile == "null"
                            ? const CircleAvatar(
                                foregroundColor: Colors.white,
                                radius: 25,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person),
                              )
                            : ClipOval(
                                child: CachedNetworkImage(
                                height: 50,
                                width: 50,
                                imageUrl:
                                    AppLink.userProfile + student.studentProfile!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.black26,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                              )),
                        const SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: studentID == student.studentID
                              ? const Text(
                                  "Me",
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: "Manrope",
                                      color: Colors.orange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                )
                              : Text(
                                  fullName,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: "Manrope", fontSize: 16),
                                ),
                        ),
                      ],
                    ),
                  ),
                  student.grade == "null"
                      ? const SizedBox()
                      : index > 10
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
                                          fontSize: 18,
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
