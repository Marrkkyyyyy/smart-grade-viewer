import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/controller/student/student_class_page_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/data/model/student_class_model.dart';
import 'package:smart_grade_viewer/link_api.dart';
import 'package:smart_grade_viewer/view/widget/dialog_message.dart';
import 'package:smart_grade_viewer/view/widget/student/home/custom_student_list.dart';
import 'package:smart_grade_viewer/view/widget/student/home/student_send_feedback.dart';
import 'package:smart_grade_viewer/view/widget/student/home/student_view_qr.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/custom_class_header.dart';

class StudentClassPage extends StatelessWidget {
  const StudentClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentClassPageController());
    return Scaffold(
      body: GetBuilder<StudentClassPageController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    decoration: BoxDecoration(
                        color:
                            Color(int.parse('0x${controller.classItem.color}')),
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(4),
                              child: Obx(() {
                                return Row(
                                  children: [
                                    controller.studentGrade.value == ""
                                        ? const SizedBox()
                                        : controller.evaluationID.value == ""
                                            ? IconButton(
                                                onPressed: () async {
                                                  final res = await Get.toNamed(
                                                      AppRoute
                                                          .studentEvaluationPage,
                                                      arguments: {
                                                        'teacherClassID':
                                                            controller.classItem
                                                                .teacherClassID
                                                      });

                                                  if (res == true) {
                                                    controller.evaluationID
                                                        .value = "1";
                                                    showSuccessMessage(
                                                        "Your evaluation has been successfully submitted.");
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.star_border,
                                                  size: 32,
                                                  color: Color.fromARGB(
                                                      255, 255, 250, 250),
                                                ))
                                            : IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const DialogMessage(
                                                            message:
                                                                "Your evaluation for this instructor has already been submitted. Thank you for your participation.",
                                                            color: AppColor
                                                                .orange);
                                                      });
                                                },
                                                icon: const Icon(
                                                  Icons.star,
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
                                                      .classItem.linkCode!,
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.qr_code,
                                          size: 32,
                                          color: Color.fromARGB(
                                              255, 255, 250, 250),
                                        )),
                                  ],
                                );
                              })),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * .85),
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .14),
                      width: MediaQuery.of(context).size.width * .94,
                      child: Column(
                        children: [
                          CustomClassHeader(
                              classCode: controller.classItem.code!,
                              block: controller.classItem.block!,
                              semester: controller.classItem.semester!,
                              year:
                                  controller.classYearCreated.year.toString()),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            controller.fullName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: "Manrope", fontSize: 16),
                          ),
                          const Divider(
                            indent: 20,
                            thickness: 1,
                            endIndent: 20,
                            height: 20,
                          ),
                          Text(controller.classItem.name!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.studentGrade.value == ""
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 6,
                                              right: 6,
                                              top: 4,
                                              bottom: 4),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                            color: Colors.grey,
                                          ),
                                          child: Column(
                                            children: const [
                                              Text("N/A",
                                                  style: TextStyle(
                                                      fontFamily: "Manrope",
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              Text(
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
                                      ],
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 6,
                                              right: 6,
                                              top: 4,
                                              bottom: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                            color: double.parse(controller
                                                            .studentGrade
                                                            .value) >=
                                                        2 &&
                                                    double.parse(controller
                                                            .studentGrade
                                                            .value) <=
                                                        3
                                                ? Colors.orange
                                                : double.parse(controller
                                                            .studentGrade
                                                            .value) >
                                                        3
                                                    ? Colors.red
                                                    : Colors.teal,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                  controller.studentGrade.value,
                                                  style: const TextStyle(
                                                      fontFamily: "Manrope",
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w800)),
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
                                          width: 4,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                builder:
                                                    (BuildContext context) {
                                                  return StudentSendFeedback(
                                                    controller: controller,
                                                    fullName:
                                                        controller.fullName,
                                                  );
                                                });
                                          },
                                          child: const Icon(
                                            Icons.message_rounded,
                                            color: Colors.blue,
                                            size: 32,
                                          ),
                                        )
                                      ],
                                    ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.studentViewStudentList);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Students",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: "Manrope",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                        color: Colors.black45,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          controller.statusRequest == StatusRequest.success
                              ? const SizedBox()
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .16,
                                ),
                          HandlingViewRequest(
                            statusRequest: controller.statusRequest,
                            widget: controller.studentList.isEmpty
                                ? Container(
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          .16,
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

                                      StudentClassModel student =
                                          controller.studentList[index];

                                      return StudentCustomStudentList(
                                          index: (index + 1),
                                          studentID: controller.studentID!,
                                          size: MediaQuery.of(context).size,
                                          student: student);
                                    }),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .045,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                border:
                                    Border.all(color: Colors.white, width: 4),
                              ),
                              child: controller.classItem.teacherProfile ==
                                      "null"
                                  ? const CircleAvatar(
                                      foregroundColor: Colors.white,
                                      radius: 40,
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.person,
                                        size: 40,
                                      ),
                                    )
                                  : ClipOval(
                                      child: CachedNetworkImage(
                                      height: 80,
                                      width: 80,
                                      imageUrl: AppLink.userProfile +
                                          controller.classItem.teacherProfile!,
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
                            ),
                          ),
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
