import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/student/drawer/overall_grades_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/data/model/overall_grades_model.dart';

class OverallGrades extends StatelessWidget {
  const OverallGrades({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OverallGradesController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        title: const Text(
          "Overall Grades",
          style: TextStyle(fontFamily: "Manrope"),
        ),
        backgroundColor: AppColor.orange,
      ),
      body: GetBuilder<OverallGradesController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  controller.statusRequest == StatusRequest.success
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: HandlingViewRequest(
                        statusRequest: controller.statusRequest,
                        widget: controller.classList.isEmpty
                            ? Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .25,
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
                                        "No Grades Found",
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
                                children: List.generate(
                                    controller.classList.length, (index) {
                                  OverallGradesModel classList =
                                      controller.classList[index];
                                  double totalGpa = 0.0;
                                  int numClasses = classList.classes.length;

                                  for (ClassItem grade in classList.classes) {
                                    if (grade.grade != null &&
                                        grade.grade!.isNotEmpty) {
                                      totalGpa += double.parse(grade.grade!);
                                    }
                                  }

                                  double semesterGpa = numClasses > 0
                                      ? totalGpa / numClasses
                                      : 0.0;
                                  semesterGpa = double.parse(
                                      semesterGpa.toStringAsFixed(2));
                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Semester ${classList.semester}",
                                              style: const TextStyle(
                                                  fontFamily: "Manrope",
                                                  fontSize: 14),
                                            ),
                                            Text("${classList.year}",
                                                style: const TextStyle(
                                                    fontFamily: "Manrope",
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: List.generate(
                                            classList.classes.length, (index) {
                                          ClassItem classes =
                                              classList.classes[index];

                                          return Row(
                                            children: [
                                              Expanded(
                                                child: Card(
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: ListTile(
                                                    minLeadingWidth: 0,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            right: 12),
                                                    leading: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    12),
                                                          ),
                                                          color: Color(int.parse(
                                                              '0x${classes.color}'))),
                                                      width: 8,
                                                    ),
                                                    dense: true,
                                                    title: Text(
                                                      classes.code!,
                                                      style: const TextStyle(
                                                          fontFamily: "Manrope",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    trailing: Text(
                                                        classes.grade!,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Manrope",
                                                            color: double.parse(classes
                                                                            .grade!) >=
                                                                        2 &&
                                                                    double.parse(classes
                                                                            .grade!) <=
                                                                        3
                                                                ? Colors.orange
                                                                : double.parse(classes
                                                                            .grade!) >
                                                                        3
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .teal,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  color: AppColor.skyBlue,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  4))),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                              child: const Text(
                                                "GPA ",
                                                style: TextStyle(
                                                    fontFamily: "Manrope",
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              constraints: const BoxConstraints(
                                                  minWidth: 45),
                                              decoration: const BoxDecoration(
                                                  color: AppColor.orange,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  4),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  4))),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                              child: Text(
                                                "$semesterGpa",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontFamily: "Manrope",
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              )),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
