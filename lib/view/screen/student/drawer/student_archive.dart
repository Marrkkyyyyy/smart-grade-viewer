import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/controller/student/drawer/student_archive_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/student_archive_model.dart';
import 'package:smart_grade_viewer/data/model/student_class_model.dart';
import 'package:smart_grade_viewer/link_api.dart';

class StudentArchive extends StatelessWidget {
  const StudentArchive({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentArchiveController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        title: const Text(
          "Archive",
          style: TextStyle(fontFamily: "Manrope"),
        ),
        backgroundColor: AppColor.orange,
      ),
      body: GetBuilder<StudentArchiveController>(builder: (controller) {
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
                                StudentArchiveModel archive =
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
                                      StudentArchiveItem archiveItem =
                                          archive.classes[index];
                                      String fullName =
                                          "${archiveItem.firstName} ${archiveItem.lastName}";

                                      return Container(
                                        margin: const EdgeInsets.all(4),
                                        child: Slidable(
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed: controller
                                                            .statusRequestArchive ==
                                                        StatusRequest.loading
                                                    ? (context) {}
                                                    : (context) {
                                                        controller.unArchiveClass(
                                                            archiveItem
                                                                .classroomID!,
                                                            index);
                                                      },
                                                backgroundColor:
                                                    const Color(0xff8394FF),
                                                foregroundColor: Colors.white,
                                                icon: Icons.unarchive,
                                                label: "Restore",
                                              ),
                                              SlidableAction(
                                                onPressed: (context) {
                                                  controller.deleteClass(
                                                      archiveItem.classroomID!,
                                                      controller.studentID!,
                                                      archiveItem
                                                          .teacherClassID!);
                                                },
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                                label: "Delete",
                                              )
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoute.studentClassPage,
                                                  arguments: {
                                                    "classItem":
                                                        StudentClassModel(
                                                      classroomID: archiveItem
                                                          .classroomID,
                                                      studentID:
                                                          archive.studentID,
                                                      teacherClassID:
                                                          archiveItem
                                                              .teacherClassID,
                                                      isArchived:
                                                          archive.isArchived,
                                                      grade: archiveItem.grade,
                                                      studentFirstName: archive
                                                          .studentFirstName,
                                                      studentLastName: archive
                                                          .studentLastName,
                                                      studentEmailAddress: archive
                                                          .studentEmailAddress,
                                                      firstName:
                                                          archiveItem.firstName,
                                                      lastName:
                                                          archiveItem.lastName,
                                                      teacherProfile: archive
                                                          .teacherProfile,
                                                      teacherID:
                                                          archiveItem.teacherID,
                                                      classID:
                                                          archiveItem.classID,
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
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(3),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                          color: archiveItem
                                                                      .grade ==
                                                                  "null"
                                                              ? AppColor
                                                                  .darkBlue
                                                              : double.parse(archiveItem
                                                                              .grade!) >=
                                                                          2 &&
                                                                      double.parse(archiveItem
                                                                              .grade!) <=
                                                                          3
                                                                  ? Colors
                                                                      .orange
                                                                  : double.parse(archiveItem
                                                                              .grade!) >
                                                                          3
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .teal,
                                                          width: 5.5),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 6,
                                                      bottom: 6,
                                                      left: 6,
                                                    ),
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            archive.teacherProfile ==
                                                                    "null"
                                                                ? const CircleAvatar(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                    radius: 25,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey,
                                                                    child: Icon(
                                                                        Icons
                                                                            .person),
                                                                  )
                                                                : ClipOval(
                                                                    child:
                                                                        CachedNetworkImage(
                                                                    height: 50,
                                                                    width: 50,
                                                                    imageUrl: AppLink
                                                                            .userProfile +
                                                                        archive
                                                                            .teacherProfile!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder: (context,
                                                                            url) =>
                                                                        Shimmer
                                                                            .fromColors(
                                                                      baseColor:
                                                                          Colors
                                                                              .black26,
                                                                      highlightColor:
                                                                          Colors
                                                                              .white,
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .black26,
                                                                      ),
                                                                    ),
                                                                  )),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      archiveItem
                                                                          .name!,
                                                                      textAlign: TextAlign
                                                                          .start,
                                                                      maxLines:
                                                                          2,
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
                                                                  const SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Text(fullName,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black54,
                                                                          fontFamily:
                                                                              'Manrope',
                                                                          fontSize:
                                                                              14)),
                                                                ],
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 6),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        int.parse(
                                                                            '0x${archiveItem.color}')),
                                                                    borderRadius: const BorderRadius
                                                                            .only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomLeft:
                                                                            Radius.circular(20)),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            14,
                                                                        vertical:
                                                                            10),
                                                                    child: Center(
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
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 8),
                                                                  child: Text(
                                                                    "Semester ${archiveItem.semester}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            'Manrope',
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .italic,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
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
                                    })),
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
