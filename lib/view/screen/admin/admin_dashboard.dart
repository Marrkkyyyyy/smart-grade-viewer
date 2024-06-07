import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/admin/admin_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/teacher_model.dart';
import 'package:smart_grade_viewer/view/screen/admin/create_teacher.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminDashboardController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 255, 255, 255),
      body: GetBuilder<AdminDashboardController>(builder: (controller) {
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
                        color: AppColor.skyBlue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    height: Get.width * .3,
                    width: Get.width,
                    child: SafeArea(
                        child: Stack(children: [
                      IconButton(
                          onPressed: () {
                            controller.logout();
                          },
                          icon: const Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.white,
                          )),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CreateTeacher(
                                          controller: controller,
                                        );
                                      });
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      const Positioned(
                          bottom: 10,
                          left: 12,
                          child: Text("Welcome, Admin",
                              style: TextStyle(
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
                          "Teachers",
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
                      widget: controller.teacherList.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .25,
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
                                      "No Data Found",
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
                                    controller.teacherList.length, (index) {
                                  TeacherModel teacher =
                                      controller.teacherList[index];
                                  String fullName =
                                      "${teacher.lastName}, ${teacher.firstName}";
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoute.teacherDetails,
                                          arguments: {
                                            "teacherClassID":
                                                teacher.teacherClassID
                                          });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 0.5,
                                            blurRadius: 3,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.all(4),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                  color: AppColor.darkSkyBlue,
                                                  width: 5.5),
                                            ),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                            ),
                                            color: Colors.white,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: const EdgeInsets.only(
                                                  left: 6, top: 2, bottom: 2),
                                              child: Row(
                                                children: [
                                                  const CircleAvatar(
                                                    maxRadius: 25.0,
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            60, 0, 0, 0),
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Text(fullName,
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'Manrope',
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 6,
                                                    ),
                                                    child: const Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.black26,
                                                      size: 18,
                                                    ),
                                                  )
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
                            ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
