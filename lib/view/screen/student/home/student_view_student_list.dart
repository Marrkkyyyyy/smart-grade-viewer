import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/student/student_class_page_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/data/model/student_class_model.dart';

class StudentViewStudentList extends StatelessWidget {
  const StudentViewStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<StudentClassPageController>();
    return GetBuilder<StudentClassPageController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          leadingWidth: 35,
          backgroundColor: Color(int.parse('0x${controller.classItem.color}')),
          title: const Text(
            "Classmates",
            style:
                TextStyle(fontFamily: "Manrope", fontWeight: FontWeight.w600),
          ),
          actions: [
            Center(
                child: Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      "${controller.studentList.length} students",
                      style: const TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )))
          ],
        ),
        body: controller.studentList.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        AppImageASset.empty,
                        repeat: false,
                        width: 150,
                      ),
                      const Text(
                        "No Student Found",
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              )
            : GridView.count(
                padding: const EdgeInsets.all(8),
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 0.75,
                children: List.generate(
                  controller.studentList.length,
                  (index) {
                    controller.studentList.sort((a, b) =>
                        a.studentFirstName!.compareTo(b.studentFirstName!));
                    StudentClassModel student = controller.studentList[index];
                    String fullName =
                        "${student.studentFirstName} ${student.studentLastName}";
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: student.grade == "null"
                                    ? AppColor.lightBlue
                                    : double.parse(student.grade!) >= 2 &&
                                            double.parse(student.grade!) <= 3
                                        ? Colors.orange
                                        : double.parse(student.grade!) > 3
                                            ? Colors.red
                                            : Colors.teal,
                                width: 5.5,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 6, right: 6),
                                  child: Text(
                                    fullName,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      );
    });
  }
}
