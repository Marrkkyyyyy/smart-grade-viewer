import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_dashboard_controller.dart';
import 'package:smart_grade_viewer/view/screen/teacher/home/class_search_delegate.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';
import 'package:smart_grade_viewer/view/screen/teacher/drawer/teacher_drawer.dart';
import 'package:smart_grade_viewer/view/widget/teacher/home/create_class.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherDashboardController());
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: const Color.fromARGB(245, 255, 255, 255),
      drawer: TeacherDrawer(
        controller: controller,
      ),
      body: GetBuilder<TeacherDashboardController>(builder: (controller) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColor.lightIndigo,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    height: Get.width * .3,
                    width: Get.width,
                    child: SafeArea(
                        child: Stack(children: [
                      IconButton(
                          onPressed: () {
                            controller.scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.bars,
                            color: Colors.white,
                          )),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return CreateNewClass(
                                            controller: controller);
                                      });
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  showSearch(
                                      context: context,
                                      delegate: SearchClass(
                                          controller.classList,
                                          controller.statusRequest));
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 12,
                          child: Text("Welcome, ${controller.firstName!}",
                              style: const TextStyle(
                                  fontFamily: "Manrope",
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600)))
                    ])),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6, top: 4),
                    child: Row(
                      children: const [
                        Text(
                          "Classes",
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45),
                        )
                      ],
                    ),
                  ),
                  controller.statusRequest == StatusRequest.success
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .25,
                        ),
                  HandlingViewRequest(
                    statusRequest: controller.statusRequest,
                    widget: controller.classList.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .25,
                            ),
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
                                    "No Class Found",
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
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed:
                                              controller.statusRequestArchive ==
                                                      StatusRequest.loading
                                                  ? (context) {}
                                                  : (context) {
                                                      controller.archiveClass(
                                                          classItem.classID!);
                                                    },
                                          backgroundColor:
                                              const Color(0xff8394FF),
                                          foregroundColor: Colors.white,
                                          icon: Icons.archive,
                                          label: "Archive",
                                        ),
                                        // SlidableAction(
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
                                        Get.toNamed(AppRoute.teacherClassPage,
                                            arguments: {
                                              "classData": classItem
                                            });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 3,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                    color: AppColor.darkIndigo,
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
                                                      color:
                                                          AppColor.lightIndigo,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(4),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                    ),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 6),
                                                      child: Text(
                                                        "Block ${classItem.block}",
                                                        style: const TextStyle(
                                                          fontFamily: "Manrope",
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
                                                                  fontSize: 16,
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
                                                            color: Color(int.parse(
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
                                                                classItem.code!,
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      "Manrope",
                                                                  fontSize: 14,
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
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
