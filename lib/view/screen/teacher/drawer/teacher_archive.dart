import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/teacher/drawer/teacher_archive_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';
import 'package:smart_grade_viewer/data/model/teacher_archive_model.dart';

class TeacherArchive extends StatelessWidget {
  const TeacherArchive({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TeacherArchiveController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        title: const Text(
          "Archive",
          style: TextStyle(fontFamily: "Manrope"),
        ),
        backgroundColor: const Color.fromRGBO(83, 92, 145, 1.0),
      ),
      body: GetBuilder<TeacherArchiveController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * .888),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    controller.statusRequest == StatusRequest.success
                        ? const SizedBox()
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .30,
                          ),
                    HandlingViewRequest(
                      statusRequest: controller.statusRequest,
                      widget: controller.archiveList.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .27,
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
                                      "No Archive Found",
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
                                  controller.archiveList.length, (index) {
                                TeacherArchiveModel archive =
                                    controller.archiveList[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      archive.year!,
                                      style: const TextStyle(
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black45),
                                    ),
                                    Column(
                                      children: List.generate(
                                          archive.classes.length, (index) {
                                        TeacherArchiveItem archiveItem =
                                            archive.classes[index];
                                        return Slidable(
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed: controller
                                                            .statusRequestArchive ==
                                                        StatusRequest.loading
                                                    ? (context) {}
                                                    : (context) {
                                                        controller
                                                            .unArchiveClass(
                                                                archiveItem
                                                                    .classID!,
                                                                index);
                                                      },
                                                backgroundColor:
                                                    const Color(0xff8394FF),
                                                foregroundColor: Colors.white,
                                                icon: Icons.unarchive,
                                                label: "Restore",
                                              ),
                                              // SlidableAction(
                                              //   borderRadius:
                                              //       const BorderRadius.only(
                                              //           topRight:
                                              //               Radius.circular(
                                              //                   20)),
                                              //   onPressed: (context) {},
                                              //   backgroundColor: Colors.red,
                                              //   foregroundColor: Colors.white,
                                              //   icon: Icons.delete,
                                              //   label: "Delete",
                                              // )
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoute.teacherClassPage,
                                                  arguments: {
                                                    "classData": ClassModel(
                                                      teacherClassID:
                                                          archiveItem
                                                              .teacherClassID,
                                                      teacherID:
                                                          archiveItem.teacherID,
                                                      classID:
                                                          archiveItem.classID,
                                                      firstName:
                                                          archiveItem.firstName,
                                                      lastName:
                                                          archiveItem.lastName,
                                                      profile:
                                                          archiveItem.profile,
                                                      name: archiveItem.name,
                                                      code: archiveItem.code,
                                                      linkCode:
                                                          archiveItem.linkCode,
                                                      block: archiveItem.block,
                                                      semester:
                                                          archiveItem.semester,
                                                      color: archiveItem.color,
                                                      dateCreated: archiveItem
                                                          .dateCreated,
                                                      isArchived:
                                                          archive.isArchived,
                                                    )
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
                                              margin: const EdgeInsets.all(4),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(3),
                                                ),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                          color: AppColor
                                                              .darkIndigo,
                                                          width: 5.5),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 6,
                                                      bottom: 6,
                                                    ),
                                                    color: Colors.white,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppColor
                                                                .lightIndigo,
                                                            borderRadius: BorderRadius.only(
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
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        6),
                                                            child: Text(
                                                              "Block ${archiveItem.block}",
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Manrope",
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 6),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                    archiveItem
                                                                        .name!,
                                                                    textAlign:
                                                                        TextAlign
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
                                                                            FontWeight.w700)),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            6),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      int.parse(
                                                                          '0x${archiveItem.color}')),
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              20)),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          14,
                                                                      vertical:
                                                                          10),
                                                                  child: Text(
                                                                    archiveItem
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
                                        );
                                      }),
                                    ),
                                  ],
                                );
                              }),
                            ),
                    ),
                  ],
                )),
          ),
        );
      }),
    );
  }
}
