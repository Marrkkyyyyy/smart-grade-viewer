import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_class_page_controller.dart';
import 'package:smart_grade_viewer/core/api/pdf_api.dart';
import 'package:smart_grade_viewer/core/api/pdf_grades_api.dart';
import 'package:smart_grade_viewer/core/class/handling_view_shimmer_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/teacher_student_model.dart';
import 'package:smart_grade_viewer/view/widget/teacher/custom_request_shimmer.dart';
import 'package:smart_grade_viewer/view/widget/student/home/student_view_qr.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_button_rankings.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_button_request.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_class_header.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_class_name.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_class_search_bar.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_student_list.dart';

class TeacherClassPage extends StatelessWidget {
  const TeacherClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TeacherClassPageController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: GetBuilder<TeacherClassPageController>(builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.refreshData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .21,
                      decoration: BoxDecoration(
                          color: Color(
                              int.parse('0x${controller.classData.color}')),
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
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 7),
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      Text("Back",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Manrope',
                                              fontSize: 14))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  controller.statusRequest !=
                                          StatusRequest.success
                                      ? const SizedBox()
                                      : controller.studentList.isEmpty
                                          ? const SizedBox()
                                          : IconButton(
                                              onPressed: () async {
                                                final pdfFile =
                                                    await PdfGradesApi.generate(
                                                        controller.studentList,
                                                        controller
                                                            .classData.name!);
                                                PdfApi.openFile(pdfFile);
                                              },
                                              icon: const Icon(
                                                Icons.picture_as_pdf,
                                                size: 32,
                                                color: Color.fromARGB(
                                                    255, 255, 250, 250),
                                              )),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomStudentViewQR(
                                                classCode: controller
                                                    .classData.linkCode!,
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.qr_code,
                                        size: 32,
                                        color:
                                            Color.fromARGB(255, 255, 250, 250),
                                      )),
                                ],
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
                            minHeight:
                                MediaQuery.of(context).size.height * .885),
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
                            CustomClassHeader(
                                classCode: controller.classData.code!,
                                block: controller.classData.block!,
                                semester: controller.classData.semester!,
                                year: controller.classYearCreated.year
                                    .toString()),
                            const SizedBox(height: 8),
                            CustomClassName(
                                className: controller.classData.name!),
                            const Divider(
                                height: 20,
                                indent: 10,
                                endIndent: 10,
                                thickness: 1.2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButtonRequest(
                                    function: () {
                                      Get.toNamed(AppRoute.teacherRequestPage,
                                          arguments: {
                                            "classData": controller.classData
                                          });
                                    },
                                    icon: Icons.person_add,
                                    text: "Requests"),
                                CustomButtonRankings(
                                    function: () {
                                      Get.toNamed(AppRoute.teacherRankingPage,
                                          arguments: {
                                            "studentList":
                                                controller.studentList,
                                            "classData": controller.classData
                                          });
                                    },
                                    icon: FontAwesomeIcons.crown,
                                    text: "Rankings")
                              ],
                            ),
                            const SizedBox(height: 8),
                            CustomClassSearchBar(controller: controller),
                            const SizedBox(
                              height: 4,
                            ),
                            controller.statusRequest == StatusRequest.success ||
                                    controller.statusRequest ==
                                        StatusRequest.loading
                                ? const SizedBox()
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .14,
                                  ),
                            HandlingShimmerViewRequest(
                              statusRequest: controller.statusRequest,
                              shimmer: Column(
                                  children: List.generate(12, (index) {
                                return CustomRequestShimmer(
                                  size: MediaQuery.of(context).size,
                                );
                              })),
                              widget: controller.studentList.isEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .14,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          controller.studentList.length,
                                          (index) {
                                        TeacherStudentModel student =
                                            controller.studentList[index];
                                        return CustomStudentList(
                                            controller: controller,
                                            student: student);
                                      }),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
