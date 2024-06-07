import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/teacher/drawer/teacher_evaluation_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';

class TeacherEvaluation extends StatelessWidget {
  const TeacherEvaluation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherEvaluationController());
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 35,
          title: const Text(
            "Evaluation",
            style: TextStyle(fontFamily: "Manrope"),
          ),
          backgroundColor: const Color.fromRGBO(83, 92, 145, 1.0),
        ),
        body: GetBuilder<TeacherEvaluationController>(builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.refreshData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(top: 6),
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Column(
                  children: [
                    controller.statusRequest == StatusRequest.success
                        ? const SizedBox()
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                          ),
                    HandlingViewRequest(
                      statusRequest: controller.statusRequest,
                      widget: controller.classList.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .3,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
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
                                      "No Evalution Found",
                                      style: TextStyle(
                                          fontFamily: "Manrope",
                                          fontSize: 18,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 8),
                              child: Column(
                                children: List.generate(
                                    controller.classList.length, (index) {
                                  ClassModel classItem =
                                      controller.classList[index];
                                  return Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Slidable(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRoute
                                                  .teacherEvaluationDashboard,
                                              arguments: {
                                                "classData": classItem
                                              });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 0.5,
                                                blurRadius: 3,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      color:
                                                          AppColor.darkIndigo,
                                                      width: 5.5),
                                                ),
                                              ),
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  top: 6,
                                                  bottom: 6,
                                                ),
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColor
                                                            .lightIndigo,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        4),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            4)),
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 6),
                                                        child: Text(
                                                          "Block ${classItem.block}",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                "Manrope",
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                                classItem.name!,
                                                                textAlign: TextAlign
                                                                    .start,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        'Manrope',
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 6),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  int.parse(
                                                                      '0x${classItem.color}')),
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20)),
                                                            ),
                                                            child: Container(
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      maxWidth:
                                                                          70,
                                                                      minWidth:
                                                                          70),
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Center(
                                                                child: Text(
                                                                  classItem
                                                                      .code!,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        "Manrope",
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
