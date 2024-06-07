import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_ranking_page_controller.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/data/model/teacher_student_model.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_teacher_student_rankings.dart';

class TeacherRankingPage extends StatelessWidget {
  const TeacherRankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherRankingPageController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            return;
          },
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .21,
                  decoration: BoxDecoration(
                      color:
                          Color(int.parse('0x${controller.classData.color}')),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 12, top: 12),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.arrow_back_ios,
                                      size: 16, color: Colors.white),
                                  Text(
                                    "Back",
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "|",
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w100,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Rankings",
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * .885),
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .115),
                    width: MediaQuery.of(context).size.width * .94,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: controller.classData.code,
                                      style: const TextStyle(
                                          fontFamily: "Manrope",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.teal)),
                                  TextSpan(
                                      text:
                                          " / Block ${controller.classData.block}",
                                      style: const TextStyle(
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          color: Colors.black45)),
                                ],
                              ),
                            ),
                            Text(
                                "${controller.classYearCreated.year} / Semester ${controller.classData.semester}",
                                style: const TextStyle(
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: Colors.black45)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller.classData.name!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          indent: 10,
                          endIndent: 10,
                          thickness: 1.2,
                        ),
                        controller.studentList.isEmpty
                            ? Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .20,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    controller.studentList.length, (index) {
                                  controller.studentList.sort((a, b) {
                                    double gradeA =
                                        double.tryParse(a.grade ?? '') ??
                                            double.infinity;
                                    double gradeB =
                                        double.tryParse(b.grade ?? '') ??
                                            double.infinity;
                                    return gradeA.compareTo(gradeB);
                                  });

                                  TeacherStudentModel student =
                                      controller.studentList[index];
                                  return CustomTeacherStudentRankings(
                                    size: MediaQuery.of(context).size,
                                    student: student,
                                    index: index + 1,
                                  );
                                }),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
